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

run_ping() {
  local target="$1"
  local label="$2"
  info "--- Ping ${label} (${target}) ---"
  if ! command -v ping >/dev/null 2>&1; then
    info "WARN: ping not installed"
    return
  fi
  if ping -c 2 -W 2 "$target" 2>&1; then
    info "Result: replies received from ${target}"
  else
    info "Result: no reply or error for ${target} (continuing)"
  fi
  info ""
}

info "=== Connectivity checks (ping -c 2) ==="
info ""

run_ping "127.0.0.1" "localhost"

gateway=""
if command -v ip >/dev/null 2>&1; then
  gateway="$(ip route show default 2>/dev/null | awk '/default/ {print $3; exit}')"
fi

if [[ -n "$gateway" ]]; then
  run_ping "$gateway" "default gateway"
else
  info "--- Default gateway ---"
  info "No default gateway detected via 'ip route' (skipped gateway ping)"
  info ""
fi

run_ping "8.8.8.8" "Google public DNS IP"

run_ping "google.com" "google.com (tests DNS + routing)"

info "TODO: Summarize in plain language which hops work and which fail."
