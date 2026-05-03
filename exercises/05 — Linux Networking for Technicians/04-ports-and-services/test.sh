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

lc_out="$(printf '%s' "$out" | tr '[:upper:]' '[:lower:]')"

printf '%s' "$out" | grep -qF '8080' || {
  emit_result fail "task output should mention port 8080"
  exit 1
}

ok_listen_hint=0
printf '%s' "$lc_out" | grep -q 'listening' && ok_listen_hint=1
printf '%s' "$lc_out" | grep -q 'not listening' && ok_listen_hint=1

ok_local=0
printf '%s' "$lc_out" | grep -q 'localhost' && ok_local=1
printf '%s' "$out" | grep -qF '127.0.0.1' && ok_local=1
printf '%s' "$lc_out" | grep -q 'curl' && ok_local=1

[[ "$ok_listen_hint" -eq 1 ]] || {
  emit_result fail "expected listening or not listening in output"
  exit 1
}

[[ "$ok_local" -eq 1 ]] || {
  emit_result fail "expected localhost, 127.0.0.1, or curl in output"
  exit 1
}

if printf '%s' "$lc_out" | grep -q 'not listening'; then
  emit_result pass "Structural checks OK (8080 not listening — optional server per README)"
  exit 0
fi

emit_result pass "task output covers 8080, listen state, and localhost/curl"
exit 0
