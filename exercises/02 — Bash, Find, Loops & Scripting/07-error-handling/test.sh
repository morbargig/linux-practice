#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

check_no_placeholders ./error_handling.sh

bash_syntax_ok ./error_handling.sh || {
  emit_result fail "bash -n failed on error_handling.sh"
  exit 1
}

set +e
out="$(bash ./error_handling.sh 2>&1)"
ec=$?
set -e

[[ "$ec" -eq 0 ]] || {
  emit_result fail "error_handling.sh should exit successfully (handle expected errors gracefully)"
  exit 1
}

printf '%s' "$out" | grep -qF 'Directory validated ✅' || {
  emit_result fail 'error_handling.sh should validate lab directory'
  exit 1
}

printf '%s' "$out" | grep -qF 'Done ✅' || {
  emit_result fail 'error_handling.sh should finish with Done ✅'
  exit 1
}

emit_result pass "error_handling.sh demonstrates graceful failures"
exit 0
