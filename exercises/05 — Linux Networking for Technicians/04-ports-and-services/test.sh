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

if ! printf '%s' "$out" | grep -qF '8080'; then
  fail "task output should mention port 8080"
  exit 1
fi

ok_listen_hint=0
if printf '%s' "$lc_out" | grep -q 'listening'; then
  ok_listen_hint=1
fi
if printf '%s' "$lc_out" | grep -q 'not listening'; then
  ok_listen_hint=1
fi

ok_local=0
if printf '%s' "$lc_out" | grep -q 'localhost'; then
  ok_local=1
fi
if printf '%s' "$out" | grep -q '127.0.0.1'; then
  ok_local=1
fi
if printf '%s' "$lc_out" | grep -q 'curl'; then
  ok_local=1
fi

if [[ "$ok_listen_hint" -eq 0 ]]; then
  fail "expected listening or not listening in output"
  exit 1
fi

if [[ "$ok_local" -eq 0 ]]; then
  fail "expected localhost, 127.0.0.1, or curl in output"
  exit 1
fi

if printf '%s' "$lc_out" | grep -q 'not listening'; then
  warn "8080 not listening — start python3 -m http.server 8080 to see a full success path"
  exit 0
fi

pass "task output covers 8080, listen state, and localhost/curl"
exit 0
