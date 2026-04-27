#!/usr/bin/env bash
set -u

pass() {
  printf 'PASS: %s\n' "$*"
}

warn() {
  printf 'WARN: %s\n' "$*"
}

fail() {
  printf 'FAIL: %s\n' "$*"
}

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
out=""
if [[ -x "${script_dir}/task.sh" ]]; then
  out="$("${script_dir}/task.sh" 2>&1)" || true
else
  fail "task.sh missing or not executable"
  exit 1
fi

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
  pass "task output mentions hostname, IP/IPv4, and interface details"
  exit 0
fi

if [[ "$ok_host" -eq 0 ]]; then
  warn "Could not confirm hostname in output"
fi
if [[ "$ok_ip" -eq 0 ]]; then
  warn "Could not confirm IP/IPv4 information in output"
fi
if [[ "$ok_iface" -eq 0 ]]; then
  warn "Could not confirm interface details in output"
fi

if [[ "$ok_host" -eq 1 || "$ok_ip" -eq 1 || "$ok_iface" -eq 1 ]]; then
  warn "Partial match only — improve task.sh output"
  exit 0
fi

fail "task output missing expected hostname, IP, and interface clues"
exit 1
