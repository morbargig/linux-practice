#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

check_no_placeholders ./for_loop.sh ./while_loop.sh

bash_syntax_ok ./for_loop.sh ./while_loop.sh || {
  emit_result fail "bash -n failed on loop scripts"
  exit 1
}

set +e
for_out="$(bash ./for_loop.sh 2>&1)"
while_out="$(bash ./while_loop.sh 2>&1)"
set -e

[[ -n "$(printf '%s' "$for_out" | tr -d '[:space:]')" ]] || {
  emit_result fail "for_loop.sh produced no output"
  exit 1
}

[[ -n "$(printf '%s' "$while_out" | tr -d '[:space:]')" ]] || {
  emit_result fail "while_loop.sh produced no output"
  exit 1
}

emit_result pass "loop scripts execute with output"
exit 0
