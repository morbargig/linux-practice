#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

check_no_placeholders ./cron_test.sh

bash_syntax_ok ./cron_test.sh || {
  emit_result fail "bash -n failed on cron_test.sh"
  exit 1
}

set +e
out="$(bash ./cron_test.sh 2>&1)"
ec=$?
set -e

[[ "$ec" -eq 0 ]] || {
  emit_result fail "cron_test.sh should exit successfully after completing TODOs"
  exit 1
}

printf '%s' "$out" | grep -qE 'PATH=|cron|/tmp/test_cron' || {
  emit_result fail "cron_test.sh should mention PATH simulation or temp helper scripts"
  exit 1
}

emit_result pass "cron_test.sh runs PATH/cron simulation steps"
exit 0
