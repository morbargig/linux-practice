#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

[[ -f ./manage_groups.sh ]] || {
  emit_result fail "manage_groups.sh missing"
  exit 1
}

bash_syntax_ok ./manage_groups.sh || {
  emit_result fail "bash -n reports syntax errors in manage_groups.sh"
  exit 1
}

check_no_placeholders ./manage_groups.sh

emit_result skip "Script has no _____ placeholders; group changes are not executed in CI — verify with instructor/lab VM."
exit 0
