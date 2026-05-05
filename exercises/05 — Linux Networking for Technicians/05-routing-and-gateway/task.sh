#!/usr/bin/env bash
set -u

info() {
  printf '%s\n' "$*"
}

# TODO: Show routing table and explain default/gateway path. Output must reference
# default, gateway, route, and interface or dev (see README).
# HINT: ip route show, ip route show default, ip route get 8.8.8.8

PATH="/sbin:/usr/sbin:/usr/local/sbin:$PATH"

info "=== Routing table ==="
_____
