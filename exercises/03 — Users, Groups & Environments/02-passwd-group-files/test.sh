#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

check_no_placeholders ./read_files.sh

bash_syntax_ok ./read_files.sh || {
  emit_result fail "bash -n failed on read_files.sh"
  exit 1
}

set +e
out="$(bash ./read_files.sh 2>&1)"
ec=$?
set -e

[[ "$ec" -eq 0 ]] || {
  emit_result fail "read_files.sh should exit successfully"
  exit 1
}

printf '%s' "$out" | grep -q '^root:' || printf '%s' "$out" | grep -q 'root:x:' || {
  emit_result fail "read_files.sh should display the root entry from /etc/passwd"
  exit 1
}

lines="$(printf '%s' "$out" | wc -l | tr -d ' ')"
[[ "${lines:-0}" -ge 4 ]] || {
  emit_result fail "read_files.sh should emit multiple passwd/group summaries"
  exit 1
}

emit_result pass "read_files.sh inspects passwd/group files"
exit 0
