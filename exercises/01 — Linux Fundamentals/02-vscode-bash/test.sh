#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

check_no_placeholders ./hello.sh

bash_syntax_ok ./hello.sh || {
  emit_result fail "bash -n failed on hello.sh"
  exit 1
}

set +e
out="$(bash ./hello.sh 2>&1)"
set -e

lc="$(printf '%s' "$out" | tr '[:upper:]' '[:lower:]')"
printf '%s' "$lc" | grep -qE 'hello,\s*linux!|hello linux' || {
  emit_result fail 'hello.sh should print "Hello, Linux!" (case-insensitive)'
  exit 1
}

emit_result pass "hello.sh prints greeting"
exit 0
