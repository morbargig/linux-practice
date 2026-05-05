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

info "=== Hostname ==="
hostname

info ""
info "=== IP addresses (hostname -I) ==="
if command -v hostname >/dev/null 2>&1; then
  hostname -I 2>/dev/null || info "(hostname -I not available or no addresses)"
else
  info "WARN: hostname command not found"
fi

info ""
info "=== Network interfaces (ip link / ip address) ==="
if command -v ip >/dev/null 2>&1; then
  ip link show
  info ""
  ip address show
else
  info "WARN: ip command not found; try installing iproute2"
fi

info ""
info "=== Default route (if available) ==="
if command -v ip >/dev/null 2>&1; then
  ip route show default 2>/dev/null || info "(no default route shown)"
else
  info "(skipped: ip not available)"
fi

info ""
info "TODO: Add clearer section headers and parse output so each interface is summarized in one line."
info "TODO: Highlight loopback vs main interface and UP/DOWN state in your own words."
