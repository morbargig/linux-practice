#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

check_no_placeholders ./sed_basics.sh

bash_syntax_ok ./sed_basics.sh || {
  emit_result fail "bash -n failed on sed_basics.sh"
  exit 1
}

set +e
out="$(bash ./sed_basics.sh 2>&1)"
ec=$?
set -e

[[ "$ec" -eq 0 ]] || {
  emit_result fail "sed_basics.sh should exit successfully"
  exit 1
}

lc="$(printf '%s' "$out" | tr '[:upper:]' '[:lower:]')"
printf '%s' "$lc" | grep -q sed || {
  emit_result fail "sed_basics.sh should exercise sed"
  exit 1
}

emit_result pass "sed_basics.sh runs sed exercises"
exit 0
