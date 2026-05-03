#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

check_no_placeholders ./ownership.sh

bash_syntax_ok ./ownership.sh || {
  emit_result fail "bash -n failed on ownership.sh"
  exit 1
}

set +e
out="$(bash ./ownership.sh 2>&1)"
ec=$?
set -e

[[ "$ec" -eq 0 ]] || {
  emit_result fail "ownership.sh should exit successfully"
  exit 1
}

lc="$(printf '%s' "$out" | tr '[:upper:]' '[:lower:]')"
printf '%s' "$lc" | grep -qE 'chown|chgrp|owner|group' || {
  emit_result fail "ownership.sh should mention ownership tooling"
  exit 1
}

emit_result pass "ownership.sh demonstrates ownership concepts"
exit 0
