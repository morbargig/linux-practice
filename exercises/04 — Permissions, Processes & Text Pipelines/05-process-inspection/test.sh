#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

check_no_placeholders ./process_inspect.sh

bash_syntax_ok ./process_inspect.sh || {
  emit_result fail "bash -n failed on process_inspect.sh"
  exit 1
}

set +e
out="$(bash ./process_inspect.sh 2>&1)"
ec=$?
set -e

[[ "$ec" -eq 0 ]] || {
  emit_result fail "process_inspect.sh should exit successfully"
  exit 1
}

lc="$(printf '%s' "$out" | tr '[:upper:]' '[:lower:]')"
printf '%s' "$lc" | grep -qE '\bps\b|pid|process' || {
  emit_result fail "process_inspect.sh should inspect processes"
  exit 1
}

emit_result pass "process_inspect.sh demonstrates ps-style inspection"
exit 0
