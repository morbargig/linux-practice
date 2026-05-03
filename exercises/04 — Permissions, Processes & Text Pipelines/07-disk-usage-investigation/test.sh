#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

check_no_placeholders ./disk_investigation.sh

bash_syntax_ok ./disk_investigation.sh || {
  emit_result fail "bash -n failed on disk_investigation.sh"
  exit 1
}

set +e
out="$(bash ./disk_investigation.sh 2>&1)"
ec=$?
set -e

[[ "$ec" -eq 0 ]] || {
  emit_result fail "disk_investigation.sh should exit successfully"
  exit 1
}

lc="$(printf '%s' "$out" | tr '[:upper:]' '[:lower:]')"
printf '%s' "$lc" | grep -qE '\bdf\b|\bdu\b|disk|filesystem|mount' || {
  emit_result fail "disk_investigation.sh should mention df/du style inspection"
  exit 1
}

emit_result pass "disk_investigation.sh exercises disk usage tooling"
exit 0
