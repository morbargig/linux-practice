#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

check_no_placeholders ./piping.sh

bash_syntax_ok ./piping.sh || {
  emit_result fail "bash -n failed on piping.sh"
  exit 1
}

set +e
out="$(bash ./piping.sh 2>&1)"
ec=$?
set -e

[[ "$ec" -eq 0 ]] || {
  emit_result fail "piping.sh should exit successfully"
  exit 1
}

printf '%s' "$out" | grep -qF 'File list saved' || {
  emit_result fail 'piping.sh should mention saving file list output'
  exit 1
}

printf '%s' "$out" | grep -qF 'ERROR lines found:' || {
  emit_result fail 'piping.sh should report ERROR lines found'
  exit 1
}

printf '%s' "$out" | grep -qF 'Done ✅' || {
  emit_result fail 'piping.sh should finish with Done ✅'
  exit 1
}

emit_result pass "piping.sh demonstrates pipes and redirection end-to-end"
exit 0
