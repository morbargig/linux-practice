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

ok_host=0
if printf '%s' "$lc_out" | grep -qE 'hostname|=== hostname'; then
  ok_host=1
fi
hn="$(hostname 2>/dev/null || true)"
if [[ -n "$hn" ]] && printf '%s' "$out" | grep -qF "$hn"; then
  ok_host=1
fi

ok_ip=0
if printf '%s' "$lc_out" | grep -qE '\bip\b|ipv4|[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+'; then
  ok_ip=1
fi

ok_iface=0
if printf '%s' "$lc_out" | grep -qE 'interface|inet |link/ether|^[0-9]+:|lo:|eth|enp|wlan'; then
  ok_iface=1
fi

if [[ "$ok_host" -eq 1 && "$ok_ip" -eq 1 && "$ok_iface" -eq 1 ]]; then
  emit_result pass "task output mentions hostname, IP/IPv4, and interface details"
  exit 0
fi

if [[ "$ok_host" -eq 1 || "$ok_ip" -eq 1 || "$ok_iface" -eq 1 ]]; then
  emit_result fail "partial output — include hostname, IPv4/IP usage, and interface details"
  exit 1
fi

emit_result fail "task output missing hostname, IP/IPv4, and interface clues"
exit 1
