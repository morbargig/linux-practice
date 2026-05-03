#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

check_no_placeholders ./awk_report.sh

bash_syntax_ok ./awk_report.sh || {
  emit_result fail "bash -n failed on awk_report.sh"
  exit 1
}

set +e
out="$(bash ./awk_report.sh 2>&1)"
ec=$?
set -e

[[ "$ec" -eq 0 ]] || {
  emit_result fail "awk_report.sh should exit successfully"
  exit 1
}

lc="$(printf '%s' "$out" | tr '[:upper:]' '[:lower:]')"
printf '%s' "$lc" | grep -q awk || {
  emit_result fail "awk_report.sh should exercise awk"
  exit 1
}

emit_result pass "awk_report.sh generates awk-based summaries"
exit 0
