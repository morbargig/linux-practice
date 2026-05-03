#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

check_no_placeholders ./chmod_practice.sh

bash_syntax_ok ./chmod_practice.sh || {
  emit_result fail "bash -n failed on chmod_practice.sh"
  exit 1
}

set +e
out="$(bash ./chmod_practice.sh 2>&1)"
ec=$?
set -e

[[ "$ec" -eq 0 ]] || {
  emit_result fail "chmod_practice.sh should exit successfully"
  exit 1
}

lc="$(printf '%s' "$out" | tr '[:upper:]' '[:lower:]')"
printf '%s' "$lc" | grep -q chmod || {
  emit_result fail "chmod_practice.sh should exercise chmod"
  exit 1
}

emit_result pass "chmod_practice.sh completes chmod drills"
exit 0
