#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

check_no_placeholders ./file_ops.sh

bash_syntax_ok ./file_ops.sh || {
  emit_result fail "bash -n failed on file_ops.sh"
  exit 1
}

set +e
out="$(bash ./file_ops.sh 2>&1)"
ec=$?
set -e

[[ "$ec" -eq 0 ]] || {
  emit_result fail "file_ops.sh should exit successfully"
  exit 1
}

lc="$(printf '%s' "$out" | tr '[:upper:]' '[:lower:]')"
printf '%s' "$lc" | grep -qE 'mkdir|cp |mv |rm ' || {
  emit_result fail "file_ops.sh output should mention mkdir/cp/mv/rm workflow"
  exit 1
}

emit_result pass "file_ops.sh completes file operations demo"
exit 0
