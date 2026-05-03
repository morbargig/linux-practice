#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

check_no_placeholders ./process_logs.sh

bash_syntax_ok ./process_logs.sh || {
  emit_result fail "bash -n failed on process_logs.sh"
  exit 1
}

set +e
out="$(bash ./process_logs.sh 2>&1)"
set -e

printf '%s' "$out" | grep -qi '\.log' || {
  emit_result fail "process_logs.sh should mention .log files"
  exit 1
}

emit_result pass "process_logs.sh scans logs under lab/files"
exit 0
