#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

check_no_placeholders ./fix_executable.sh

bash_syntax_ok ./fix_executable.sh || {
  emit_result fail "bash -n failed on fix_executable.sh"
  exit 1
}

set +e
out="$(bash ./fix_executable.sh 2>&1)"
ec=$?
set -e

[[ "$ec" -eq 0 ]] || {
  emit_result fail "fix_executable.sh should exit successfully"
  exit 1
}

lc="$(printf '%s' "$out" | tr '[:upper:]' '[:lower:]')"
printf '%s' "$lc" | grep -qE 'chmod|executable|permission denied|\./' || {
  emit_result fail "fix_executable.sh should discuss chmod/exec troubleshooting"
  exit 1
}

emit_result pass "fix_executable.sh repairs executable scripts"
exit 0
