#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

check_no_placeholders ./sudo_demo.sh

bash_syntax_ok ./sudo_demo.sh || {
  emit_result fail "bash -n failed on sudo_demo.sh"
  exit 1
}

set +e
out="$(bash ./sudo_demo.sh 2>&1)"
ec=$?
set -e

[[ "$ec" -eq 0 ]] || {
  emit_result fail "sudo_demo.sh should exit successfully"
  exit 1
}

lc="$(printf '%s' "$out" | tr '[:upper:]' '[:lower:]')"
printf '%s' "$lc" | grep -q sudo || {
  emit_result fail "sudo_demo.sh should reference sudo usage"
  exit 1
}

printf '%s' "$lc" | grep -q '/root' || {
  emit_result fail "sudo_demo.sh should attempt to inspect /root"
  exit 1
}

emit_result pass "sudo_demo.sh demonstrates privileged vs unprivileged listing"
exit 0
