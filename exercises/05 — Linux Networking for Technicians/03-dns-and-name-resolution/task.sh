#!/usr/bin/env bash
set -u

info() {
  printf '%s\n' "$*"
}

# TODO: Show DNS servers and lookup google.com. Output must reference nameserver/DNS,
# google.com, and nslookup OR dig OR /etc/resolv.conf (tests are case-insensitive on content).
# HINT: cat/grep /etc/resolv.conf, nslookup, dig

info "=== DNS (/etc/resolv.conf) ==="
_____

info ""
info "=== Lookup: google.com ==="
_____
