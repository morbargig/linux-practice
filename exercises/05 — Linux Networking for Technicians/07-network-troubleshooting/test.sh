#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

[[ -f ./task.sh ]] || {
  emit_result fail "task.sh missing"
  exit 1
}

check_no_placeholders ./task.sh

bash_syntax_ok ./task.sh || {
  emit_result fail "bash -n reports syntax errors in task.sh"
  exit 1
}

set +e
out="$(bash ./task.sh 2>&1)"
set -e

lc_out="$(printf '%s' "$out" | tr '[:upper:]' '[:lower:]')"

need=("ip information" "routing" "connectivity" "dns" "likely")
for key in "${need[@]}"; do
  if ! printf '%s' "$lc_out" | grep -qF "$key"; then
    emit_result fail "Expected section heading containing: ${key}"
    exit 1
  fi
done

emit_result pass "Report contains IP, Routing, Connectivity, DNS, and Likely sections"
exit 0
