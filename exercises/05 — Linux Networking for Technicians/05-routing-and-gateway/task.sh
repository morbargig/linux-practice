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

if ! command -v ip >/dev/null 2>&1; then
  info "WARN: ip command not found"
  exit 0
fi

info "=== Full routing table ==="
ip route show

info ""
info "=== Default route / gateway hint ==="
if ip route show default 2>/dev/null | grep -q .; then
  ip route show default
  gw="$(ip route show default 2>/dev/null | awk '/default/ {print $3; exit}')"
  dev="$(ip route show default 2>/dev/null | awk '/default/ {print $5; exit}')"
  if [[ -n "$gw" ]]; then
    info "Detected gateway IP: ${gw}"
  else
    info "(could not parse gateway from default route)"
  fi
  if [[ -n "$dev" ]]; then
    info "Detected outgoing interface (dev): ${dev}"
  else
    info "(could not parse interface from default route)"
  fi
else
  info "No default route shown — check interface and DHCP/static config"
fi

info ""
info "=== Path lookup: ip route get 8.8.8.8 ==="
if out="$(ip route get 8.8.8.8 2>&1)"; then
  printf '%s\n' "$out"
else
  info "WARN: ip route get failed: $out"
fi

info ""
info "TODO: In your notes, describe what breaks when the default route is missing."
