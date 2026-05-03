#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

check_no_placeholders ./env_vars.sh

bash_syntax_ok ./env_vars.sh || {
  emit_result fail "bash -n failed on env_vars.sh"
  exit 1
}

set +e
out="$(bash ./env_vars.sh 2>&1)"
ec=$?
set -e

[[ "$ec" -eq 0 ]] || {
  emit_result fail "env_vars.sh should exit successfully"
  exit 1
}

printf '%s' "$out" | grep -qE '/bin|/usr|/home' || {
  emit_result fail "env_vars.sh should print real environment paths"
  exit 1
}

emit_result pass "env_vars.sh prints core environment variables"
exit 0
