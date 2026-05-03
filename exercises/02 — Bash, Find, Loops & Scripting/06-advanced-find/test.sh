#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

check_no_placeholders ./advanced_find.sh

bash_syntax_ok ./advanced_find.sh || {
  emit_result fail "bash -n failed on advanced_find.sh"
  exit 1
}

set +e
out="$(bash ./advanced_find.sh 2>&1)"
ec=$?
set -e

[[ "$ec" -eq 0 ]] || {
  emit_result fail "advanced_find.sh should exit successfully"
  exit 1
}

lc="$(printf '%s' "$out" | tr '[:upper:]' '[:lower:]')"
printf '%s' "$lc" | grep -q find || {
  emit_result fail "advanced_find.sh should exercise find"
  exit 1
}

emit_result pass "advanced_find.sh completes find challenges"
exit 0
