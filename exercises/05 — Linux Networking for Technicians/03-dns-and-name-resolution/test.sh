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

ok_dns=0
printf '%s' "$lc_out" | grep -qE 'dns|nameserver' && ok_dns=1

ok_google=0
printf '%s' "$out" | grep -qF 'google.com' && ok_google=1

ok_tool=0
printf '%s' "$lc_out" | grep -q 'nslookup' && ok_tool=1
printf '%s' "$lc_out" | grep -q 'dig ' && ok_tool=1
printf '%s' "$lc_out" | grep -q 'resolv.conf' && ok_tool=1

if [[ "$ok_dns" -eq 1 && "$ok_google" -eq 1 && "$ok_tool" -eq 1 ]]; then
  emit_result pass "DNS/nameserver, google.com, and nslookup/dig/resolv.conf referenced"
  exit 0
fi

emit_result fail "Expected DNS/nameserver hints, google.com, and nslookup or dig or /etc/resolv.conf"
exit 1
