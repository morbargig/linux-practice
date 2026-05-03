#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

check_no_placeholders ./identity.sh

bash_syntax_ok ./identity.sh || {
  emit_result fail "bash -n failed on identity.sh"
  exit 1
}

set +e
out="$(bash ./identity.sh 2>&1)"
ec=$?
set -e

[[ "$ec" -eq 0 ]] || {
  emit_result fail "identity.sh should exit successfully"
  exit 1
}

printf '%s' "$out" | grep -qE 'uid=|gid=|groups=' || {
  emit_result fail "identity.sh output should include id-style uid/gid/groups information"
  exit 1
}

emit_result pass "identity.sh demonstrates whoami/id usage"
exit 0
