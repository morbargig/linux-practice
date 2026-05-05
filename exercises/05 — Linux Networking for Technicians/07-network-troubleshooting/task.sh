#!/usr/bin/env bash
set -u

info() {
  printf '%s\n' "$*"
}

# TODO: Build a short diagnostic report with section headings containing (case-insensitive):
#   ip information, routing, connectivity, dns, likely
# Use ping/ip/route/resolv.conf as needed (see README).

info "========== IP Information =========="
_____

info ""
info "========== Routing =========="
_____

info ""
info "========== Connectivity =========="
_____

info ""
info "========== DNS =========="
_____

info ""
info "========== Likely Issue =========="
_____
