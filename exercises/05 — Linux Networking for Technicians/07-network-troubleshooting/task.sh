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

ping_ok() {
  local target="$1"
  if ! command -v ping >/dev/null 2>&1; then
    warn "ping not installed"
    return 1
  fi
  ping -c 1 -W 2 "$target" >/dev/null 2>&1
}

info "========== IP Information =========="
if command -v ip >/dev/null 2>&1; then
  ip -brief address show
else
  warn "ip not installed"
fi
if command -v hostname >/dev/null 2>&1; then
  info "hostname -I: $(hostname -I 2>/dev/null || true)"
fi

info ""
info "========== Routing =========="
if command -v ip >/dev/null 2>&1; then
  ip route show default 2>/dev/null || info "(no default route)"
  gw="$(ip route show default 2>/dev/null | awk '/default/ {print $3; exit}')"
else
  gw=""
  warn "ip not installed — cannot show routes"
fi

info ""
info "========== Connectivity =========="
if ping_ok "127.0.0.1"; then
  info "127.0.0.1: OK"
else
  info "127.0.0.1: FAIL or unreachable"
fi

if [[ -n "${gw:-}" ]]; then
  if ping_ok "$gw"; then
    info "Gateway ${gw}: OK"
  else
    info "Gateway ${gw}: FAIL or unreachable"
  fi
else
  info "Gateway: (not detected — skipped ping)"
fi

if ping_ok "8.8.8.8"; then
  info "8.8.8.8: OK"
else
  info "8.8.8.8: FAIL or unreachable"
fi

if ping_ok "google.com"; then
  info "google.com: OK"
else
  info "google.com: FAIL or lookup/ping issue"
fi

info ""
info "========== DNS =========="
if [[ -r /etc/resolv.conf ]]; then
  grep -E '^[[:space:]]*nameserver' /etc/resolv.conf 2>/dev/null || info "(no nameserver lines)"
else
  warn "cannot read /etc/resolv.conf"
fi

info ""
info "========== Likely Issue =========="
if ping_ok "8.8.8.8" && ! ping_ok "google.com"; then
  info "Likely: DNS or name resolution problem (IP path works, names do not)."
elif ! ping_ok "8.8.8.8"; then
  info "Likely: routing or upstream connectivity (cannot reach public IP)."
else
  info "Likely: no obvious fault from these quick checks — gather more evidence."
fi

info ""
info "TODO: Replace the generic Likely line with your own conclusion after reviewing the section outputs."
