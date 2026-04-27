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

info "=== Firewall basics (read-only by default) ==="
info ""
info "This script does NOT run ufw allow, deny, or delete."
info "It only shows safe commands for you to run manually in a lab."
info ""

if ! command -v ufw >/dev/null 2>&1; then
  warn "ufw not installed — common on minimal images; try: sudo apt install ufw"
  exit 0
fi

info "Example: see status (requires sudo and may prompt for password):"
info "  sudo ufw status verbose"
info ""
info "Optional lab steps (run yourself, only with permission):"
info "  sudo ufw allow 8080"
info "  sudo ufw status verbose"
info "  sudo ufw delete allow 8080"
info "  sudo ufw status verbose"
info ""

read -r -p "Run 'sudo ufw status verbose' now? [y/N] " choice
case "${choice}" in
  y|Y|yes|YES)
    if command -v sudo >/dev/null 2>&1; then
      sudo ufw status verbose
    else
      warn "sudo not available; run ufw status manually as root"
    fi
    ;;
  *)
    info "Skipped live ufw status — run it yourself when ready."
    ;;
esac

info ""
info "TODO: Record whether UFW was active and one rule you recognized."
