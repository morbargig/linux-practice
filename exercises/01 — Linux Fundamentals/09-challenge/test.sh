#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

check_no_placeholders ./analyzer.sh

bash_syntax_ok ./analyzer.sh || {
  emit_result fail "bash -n failed on analyzer.sh"
  exit 1
}

lab_rel="../../lab/files"

set +e
out="$(bash ./analyzer.sh "$lab_rel" 2>&1)"
ec=$?
set -e

[[ "$ec" -eq 0 ]] || {
  emit_result fail "analyzer.sh should succeed against ../../lab/files"
  exit 1
}

printf '%s' "$out" | grep -q 'TXT_COUNT=' || {
  emit_result fail "analyzer.sh must print TXT_COUNT="
  exit 1
}

printf '%s' "$out" | grep -q 'TXT_TOTAL_BYTES=' || {
  emit_result fail "analyzer.sh must print TXT_TOTAL_BYTES="
  exit 1
}

emit_result pass "analyzer.sh reports txt metrics for lab/files"
exit 0
