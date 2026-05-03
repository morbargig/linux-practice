#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

check_no_placeholders ./find_basic.sh ./find_advanced.sh

bash_syntax_ok ./find_basic.sh ./find_advanced.sh || {
  emit_result fail "bash -n failed on find scripts"
  exit 1
}

set +e
basic_out="$(bash ./find_basic.sh 2>&1)"
adv_out="$(bash ./find_advanced.sh 2>&1)"
set -e

printf '%s' "$basic_out" | grep -qE '\.conf|app\.conf|db\.conf' || {
  emit_result fail "find_basic.sh should locate .conf files under lab/files"
  exit 1
}

printf '%s' "$basic_out" | grep -qE 'big\.bin|[[:digit:]]+[Mm]|\+5M' || {
  emit_result fail "find_basic.sh should include a size-based search (+5M)"
  exit 1
}

printf '%s' "$adv_out" | grep -qi find || {
  emit_result fail "find_advanced.sh should exercise find"
  exit 1
}

emit_result pass "find_basic.sh and find_advanced.sh run with plausible output"
exit 0
