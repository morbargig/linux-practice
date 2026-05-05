#!/usr/bin/env bash
set -u

info() {
  printf '%s\n' "$*"
}

# TODO: Check whether TCP port 8080 is listening on localhost; mention 8080, listening/not listening,
# and localhost or 127.0.0.1 or curl output (see README).
# HINT: ss -tulpen, curl http://127.0.0.1:8080/

info "=== Port 8080 check ==="
_____
