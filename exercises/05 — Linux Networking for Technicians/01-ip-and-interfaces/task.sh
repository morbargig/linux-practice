#!/usr/bin/env bash
set -u

info() {
  printf '%s\n' "$*"
}

# TODO: Print hostname, IPv4-related output, and interface details (see README).
# HINT: hostname, hostname -I, ip link, ip address, ip route show default

info "=== Hostname ==="
_____

info ""
info "=== IP addresses (hostname -I) ==="
_____

info ""
info "=== Network interfaces (ip link / ip address) ==="
_____

info ""
info "=== Default route (if available) ==="
_____
