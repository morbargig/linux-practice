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

ok_dns=0
if printf '%s' "$lc_out" | grep -qE 'dns|nameserver'; then
  ok_dns=1
fi

ok_google=0
if printf '%s' "$out" | grep -qF 'google.com'; then
  ok_google=1
fi

ok_tool=0
if printf '%s' "$lc_out" | grep -q 'nslookup'; then
  ok_tool=1
fi
if printf '%s' "$lc_out" | grep -q 'dig '; then
  ok_tool=1
fi
if printf '%s' "$lc_out" | grep -q 'resolv.conf'; then
  ok_tool=1
fi

if [[ "$ok_dns" -eq 1 && "$ok_google" -eq 1 && "$ok_tool" -eq 1 ]]; then
  pass "output references DNS/nameserver, google.com, and nslookup/dig/resolv.conf"
  exit 0
fi

if [[ "$ok_dns" -eq 0 ]]; then
  warn "expected DNS or nameserver mention"
fi
if [[ "$ok_google" -eq 0 ]]; then
  warn "expected google.com in output"
fi
if [[ "$ok_tool" -eq 0 ]]; then
  warn "expected nslookup, dig, or resolv.conf in output"
fi

fail "improve task.sh so output is easier to verify"
exit 1
