#!/usr/bin/env bash
# Install packages listed in .github/ci-apt-packages.txt (comments / blank lines ignored).
# Call after apt-get update (e.g. prepare) or after restoring ci-apt-snapshot.tgz (test jobs).
set -euo pipefail

packages_file="${1:-.github/ci-apt-packages.txt}"
mapfile -t pkgs < <(grep -v '^[[:space:]]*#' "$packages_file" | grep -v '^[[:space:]]*$' || true)
if ((${#pkgs[@]} == 0)); then
  exit 0
fi
sudo apt-get install -y --no-install-recommends "${pkgs[@]}"
