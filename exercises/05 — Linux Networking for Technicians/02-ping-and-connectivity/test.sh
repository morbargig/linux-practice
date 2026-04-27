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

ok=1
if ! printf '%s' "$out" | grep -qF '127.0.0.1'; then
  ok=0
fi
if ! printf '%s' "$out" | grep -qF '8.8.8.8'; then
  ok=0
fi
if ! printf '%s' "$out" | grep -qF 'google.com'; then
  ok=0
fi

if [[ "$ok" -eq 1 ]]; then
  pass "task output includes localhost, 8.8.8.8, and google.com checks"
  exit 0
fi

warn "task output missing one of: 127.0.0.1, 8.8.8.8, google.com"
exit 0
