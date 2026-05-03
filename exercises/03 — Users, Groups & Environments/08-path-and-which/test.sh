#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

check_no_placeholders ./path_debug.sh

bash_syntax_ok ./path_debug.sh || {
  emit_result fail "bash -n failed on path_debug.sh"
  exit 1
}

set +e
out="$(bash ./path_debug.sh 2>&1)"
ec=$?
set -e

[[ "$ec" -eq 0 ]] || {
  emit_result fail "path_debug.sh should exit successfully"
  exit 1
}

printf '%s' "$out" | grep -qi 'hello' || {
  emit_result fail "path_debug.sh should run the hello helper script"
  exit 1
}

emit_result pass "path_debug.sh exercises PATH debugging"
exit 0
