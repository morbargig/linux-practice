#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

check_no_placeholders ./debug_me.sh

bash_syntax_ok ./debug_me.sh || {
  emit_result fail "bash -n failed on debug_me.sh"
  exit 1
}

set +e
out="$(bash ./debug_me.sh 2>&1)"
set -e

printf '%s' "$out" | grep -qF 'Hello student' || {
  emit_result fail 'debug_me.sh should print Hello student after fixing $naem typo'
  exit 1
}

if printf '%s' "$out" | grep -q 'naem'; then
  emit_result fail 'debug_me.sh still prints typo naem'
  exit 1
fi

emit_result pass "debug_me.sh prints corrected greeting"
exit 0
