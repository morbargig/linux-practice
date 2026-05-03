#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

check_no_placeholders ./text_pipelines.sh

bash_syntax_ok ./text_pipelines.sh || {
  emit_result fail "bash -n failed on text_pipelines.sh"
  exit 1
}

set +e
out="$(bash ./text_pipelines.sh 2>&1)"
ec=$?
set -e

[[ "$ec" -eq 0 ]] || {
  emit_result fail "text_pipelines.sh should exit successfully"
  exit 1
}

lc="$(printf '%s' "$out" | tr '[:upper:]' '[:lower:]')"
printf '%s' "$lc" | grep -qE 'sort|uniq|cut|grep|\|' || {
  emit_result fail "text_pipelines.sh should combine classic text utilities"
  exit 1
}

emit_result pass "text_pipelines.sh builds text-processing pipelines"
exit 0
