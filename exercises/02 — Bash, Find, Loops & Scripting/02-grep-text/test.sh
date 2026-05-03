#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

check_no_placeholders ./grep_search.sh

bash_syntax_ok ./grep_search.sh || {
  emit_result fail "bash -n failed on grep_search.sh"
  exit 1
}

set +e
out="$(bash ./grep_search.sh 2>&1)"
ec=$?
set -e

[[ "$ec" -eq 0 ]] || {
  emit_result fail "grep_search.sh should exit successfully"
  exit 1
}

lc="$(printf '%s' "$out" | tr '[:upper:]' '[:lower:]')"
printf '%s' "$lc" | grep -q grep || {
  emit_result fail "grep_search.sh should exercise grep"
  exit 1
}

emit_result pass "grep_search.sh demonstrates grep usage"
exit 0
