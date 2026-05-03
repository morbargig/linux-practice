#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

PATH="/sbin:/usr/sbin:/usr/local/sbin:$PATH"

[[ -f ./task.sh ]] || {
  emit_result fail "task.sh missing"
  exit 1
}

check_no_placeholders ./task.sh

bash_syntax_ok ./task.sh || {
  emit_result fail "bash -n reports syntax errors in task.sh"
  exit 1
}

command -v ip >/dev/null 2>&1 || {
  emit_result skip "ip command unavailable on this runner"
  exit 0
}

set +e
out="$(bash ./task.sh 2>&1)"
set -e

lc_out="$(printf '%s' "$out" | tr '[:upper:]' '[:lower:]')"

ok_def=0
printf '%s' "$lc_out" | grep -q 'default' && ok_def=1
printf '%s' "$lc_out" | grep -q 'gateway' && ok_def=1

ok_route=0
printf '%s' "$lc_out" | grep -q 'route' && ok_route=1

ok_dev=0
printf '%s' "$lc_out" | grep -qE '\bdev\b|interface' && ok_dev=1

if [[ "$ok_def" -eq 1 && "$ok_route" -eq 1 && "$ok_dev" -eq 1 ]]; then
  emit_result pass "Output references default/gateway, route, and interface/dev"
  exit 0
fi

emit_result fail "Improve labels so default/gateway, route, and interface/dev appear"
exit 1
