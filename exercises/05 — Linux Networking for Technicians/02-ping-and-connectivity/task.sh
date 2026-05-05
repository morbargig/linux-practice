#!/usr/bin/env bash
set -u

info() {
  printf '%s\n' "$*"
}

# TODO: Run ping (or equivalent) checks and print results so stdout mentions ALL of:
#   127.0.0.1, 8.8.8.8, and google.com
# HINT: ping -c 2; optional: default gateway from `ip route show default`

info "=== Connectivity checks (ping -c 2) ==="
_____
