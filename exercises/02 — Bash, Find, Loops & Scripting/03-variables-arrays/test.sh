#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

check_no_placeholders ./variables.sh

bash_syntax_ok ./variables.sh || {
  emit_result fail "bash -n failed on variables.sh"
  exit 1
}

set +e
out="$(bash ./variables.sh 2>&1)"
ec=$?
set -e

[[ "$ec" -eq 0 ]] || {
  emit_result fail "variables.sh should exit successfully"
  exit 1
}

[[ -n "$(printf '%s' "$out" | tr -d '[:space:]')" ]] || {
  emit_result fail "variables.sh produced no output"
  exit 1
}

emit_result pass "variables.sh runs with output"
exit 0
