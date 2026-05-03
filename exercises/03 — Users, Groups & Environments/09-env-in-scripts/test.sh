#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

check_no_placeholders ./showenv.sh

bash_syntax_ok ./showenv.sh || {
  emit_result fail "bash -n failed on showenv.sh"
  exit 1
}

set +e
out="$(bash ./showenv.sh 2>&1)"
ec=$?
set -e

[[ "$ec" -eq 0 ]] || {
  emit_result fail "showenv.sh should exit successfully"
  exit 1
}

printf '%s' "$out" | grep -q 'MY_EXPORTED=' || {
  emit_result fail "showenv.sh should print MY_EXPORTED"
  exit 1
}

printf '%s' "$out" | grep -q 'Subshell - MY_EXPORTED=' || {
  emit_result fail "showenv.sh should demonstrate subshell visibility"
  exit 1
}

emit_result pass "showenv.sh demonstrates export vs local scope"
exit 0
