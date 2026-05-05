#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

[[ -f ./create_user.sh ]] || {
  emit_result fail "create_user.sh missing"
  exit 1
}

bash_syntax_ok ./create_user.sh || {
  emit_result fail "bash -n reports syntax errors in create_user.sh"
  exit 1
}

check_no_placeholders ./create_user.sh

emit_result skip "Script has no _____ placeholders; useradd/passwd are not executed in CI — verify in a lab VM."
exit 0
