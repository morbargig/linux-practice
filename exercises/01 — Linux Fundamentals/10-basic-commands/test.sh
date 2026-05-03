#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

check_no_placeholders ./basic_commands.sh

bash_syntax_ok ./basic_commands.sh || {
  emit_result fail "bash -n failed on basic_commands.sh"
  exit 1
}

set +e
out="$(bash ./basic_commands.sh 2>&1)"
set -e

printf '%s' "$out" | grep -qF 'alpha' || {
  emit_result fail "basic_commands.sh should display contents of lab/files/a.txt (alpha)"
  exit 1
}

printf '%s' "$out" | grep -q 'Lines:' || {
  emit_result fail "basic_commands.sh should report Lines: from wc -l"
  exit 1
}

emit_result pass "basic_commands.sh exercises ls/cat/wc flows against lab/files"
exit 0
