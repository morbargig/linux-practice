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

info() {
  printf '%s\n' "$*"
}

resolv="/etc/resolv.conf"

info "=== DNS servers (${resolv}) ==="
if [[ -r "$resolv" ]]; then
  grep -E '^[[:space:]]*(nameserver|search|domain)' "$resolv" 2>/dev/null || info "(no nameserver/search lines found)"
else
  info "WARN: cannot read ${resolv}"
fi

info ""
info "=== Lookup: google.com ==="

if command -v nslookup >/dev/null 2>&1; then
  info "--- nslookup google.com ---"
  nslookup google.com 2>&1 || info "(nslookup returned non-zero — check output above)"
elif command -v dig >/dev/null 2>&1; then
  info "nslookup not found; using dig only"
else
  info "WARN: neither nslookup nor dig found (install dnsutils/bind-utils if needed)"
fi

info ""
if command -v dig >/dev/null 2>&1; then
  info "--- dig google.com ---"
  dig +time=2 +tries=1 google.com 2>&1 || info "(dig returned non-zero — check output above)"
else
  info "dig not installed; skipped"
fi

info ""
info "TODO: Explain in your notes how a nameserver turns google.com into an IP address."
