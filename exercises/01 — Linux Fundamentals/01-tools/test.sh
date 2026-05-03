#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

check_no_placeholders ./tasks.sh

bash_syntax_ok ./tasks.sh || {
  emit_result fail "bash -n failed on tasks.sh"
  exit 1
}

set +e
out="$(bash ./tasks.sh 2>&1)"
set -e

lc="$(printf '%s' "$out" | tr '[:upper:]' '[:lower:]')"
printf '%s' "$lc" | grep -q 'tree' || {
  emit_result fail "tasks.sh output should mention tree (installed check)"
  exit 1
}

emit_result pass "tasks.sh checks tree installation status"
exit 0
