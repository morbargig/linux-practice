#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

[[ -f ./task.sh ]] || {
  emit_result fail "task.sh missing"
  exit 1
}

check_no_placeholders ./task.sh

bash_syntax_ok ./task.sh || {
  emit_result fail "bash -n reports syntax errors in task.sh"
  exit 1
}

set +e
out="$(bash ./task.sh 2>&1)"
set -e

ok=1
printf '%s' "$out" | grep -qF '127.0.0.1' || ok=0
printf '%s' "$out" | grep -qF '8.8.8.8' || ok=0
printf '%s' "$out" | grep -qF 'google.com' || ok=0

if [[ "$ok" -eq 1 ]]; then
  emit_result pass "task output includes localhost, 8.8.8.8, and google.com checks"
  exit 0
fi

emit_result fail "task output must mention 127.0.0.1, 8.8.8.8, and google.com"
exit 1
