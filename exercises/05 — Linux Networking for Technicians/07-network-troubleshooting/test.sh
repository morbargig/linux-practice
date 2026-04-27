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

need=( "ip information" "routing" "connectivity" "dns" "likely" )
for key in "${need[@]}"; do
  if ! printf '%s' "$lc_out" | grep -qF "$key"; then
    fail "expected section heading containing: ${key}"
    exit 1
  fi
done

pass "report contains IP, Routing, Connectivity, DNS, and Likely sections"
exit 0
