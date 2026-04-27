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

info "=== Port 8080 check ==="
info "Target port: 8080 on localhost / 127.0.0.1"

if ! command -v ss >/dev/null 2>&1; then
  info "WARN: ss command not found (install iproute2)"
  info "Cannot tell if 8080 is listening without ss."
else
  info "--- Listening sockets mentioning 8080 ---"
  if ss -tulpen 2>/dev/null | grep -q ':8080'; then
    ss -tulpen 2>/dev/null | grep ':8080' || true
    info "Status: port 8080 appears to be listening"
  else
    info "Status: port 8080 does not appear to be listening"
    info "Start a test server with: python3 -m http.server 8080"
  fi
fi

info ""
info "=== curl localhost:8080 (if curl is available) ==="
if command -v curl >/dev/null 2>&1; then
  if curl -sS -m 3 -o /dev/null -w 'HTTP code: %{http_code}\n' "http://127.0.0.1:8080/" 2>&1; then
    :
  else
    info "(curl could not complete — server may be down or connection refused)"
  fi
else
  info "WARN: curl not installed; skipped"
fi

info ""
info "TODO: Try the same checks on a different port and record the difference."
