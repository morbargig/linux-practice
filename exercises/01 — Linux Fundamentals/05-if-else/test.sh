#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

check_no_placeholders ./conditions.sh

bash_syntax_ok ./conditions.sh || {
  emit_result fail "bash -n failed on conditions.sh"
  exit 1
}

set +e
out="$(bash ./conditions.sh 2>&1)"
set -e

printf '%s' "$out" | grep -qF 'Done' || {
  emit_result fail 'conditions.sh should print Done'
  exit 1
}

printf '%s' "$out" | grep -qE 'File exists|File not found' || {
  emit_result fail 'conditions.sh should branch on file existence'
  exit 1
}

emit_result pass "conditions.sh demonstrates conditional logic"
exit 0
