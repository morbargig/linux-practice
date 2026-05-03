#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

check_no_placeholders ./cleanup.sh

bash_syntax_ok ./cleanup.sh || {
  emit_result fail "bash -n failed on cleanup.sh"
  exit 1
}

set +e
out="$(bash ./cleanup.sh 2>&1)"
set -e

lc="$(printf '%s' "$out" | tr '[:upper:]' '[:lower:]')"
printf '%s' "$lc" | grep -qE 'find|rm|delete|tmp|old' || {
  emit_result fail "cleanup.sh should reference cleanup/find/remove concepts"
  exit 1
}

emit_result pass "cleanup.sh demonstrates cleanup workflow"
exit 0
