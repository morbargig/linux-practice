#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

check_no_placeholders ./process_control.sh

bash_syntax_ok ./process_control.sh || {
  emit_result fail "bash -n failed on process_control.sh"
  exit 1
}

set +e
out="$(bash ./process_control.sh 2>&1)"
ec=$?
set -e

[[ "$ec" -eq 0 ]] || {
  emit_result fail "process_control.sh should exit successfully"
  exit 1
}

lc="$(printf '%s' "$out" | tr '[:upper:]' '[:lower:]')"
printf '%s' "$lc" | grep -qE 'kill|jobs|bg|fg|\bps\b|signal' || {
  emit_result fail "process_control.sh should discuss job/process control"
  exit 1
}

emit_result pass "process_control.sh covers signals/job control patterns"
exit 0
