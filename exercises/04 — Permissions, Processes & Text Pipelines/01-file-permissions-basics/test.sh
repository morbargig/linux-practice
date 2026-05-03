#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

check_no_placeholders ./permissions.sh

bash_syntax_ok ./permissions.sh || {
  emit_result fail "bash -n failed on permissions.sh"
  exit 1
}

set +e
out="$(bash ./permissions.sh 2>&1)"
ec=$?
set -e

[[ "$ec" -eq 0 ]] || {
  emit_result fail "permissions.sh should exit successfully"
  exit 1
}

lc="$(printf '%s' "$out" | tr '[:upper:]' '[:lower:]')"
printf '%s' "$lc" | grep -qE 'chmod|permission|rwx|owner|group|ls -l' || {
  emit_result fail "permissions.sh should surface permission vocabulary"
  exit 1
}

emit_result pass "permissions.sh demonstrates permission inspection"
exit 0
