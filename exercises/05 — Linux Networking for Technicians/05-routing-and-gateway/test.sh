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

ok_def=0
if printf '%s' "$lc_out" | grep -q 'default'; then
  ok_def=1
fi
if printf '%s' "$lc_out" | grep -q 'gateway'; then
  ok_def=1
fi

ok_route=0
if printf '%s' "$lc_out" | grep -q 'route'; then
  ok_route=1
fi

ok_dev=0
if printf '%s' "$lc_out" | grep -qE '\bdev\b|interface'; then
  ok_dev=1
fi

if [[ "$ok_def" -eq 1 && "$ok_route" -eq 1 && "$ok_dev" -eq 1 ]]; then
  pass "output references default/gateway, route, and interface/dev"
  exit 0
fi

if ! command -v ip >/dev/null 2>&1; then
  warn "ip missing — cannot validate routing output"
  exit 0
fi

if [[ "$ok_def" -eq 0 ]]; then
  warn "expected default or gateway in output"
fi
if [[ "$ok_route" -eq 0 ]]; then
  warn "expected route in output"
fi
if [[ "$ok_dev" -eq 0 ]]; then
  warn "expected dev or interface in output"
fi

fail "improve task.sh labels so routing terms are visible"
exit 1
