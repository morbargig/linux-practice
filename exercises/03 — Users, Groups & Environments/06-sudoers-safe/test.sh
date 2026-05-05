#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

[[ -f ./visudo-report.md ]] || {
  emit_result fail "visudo-report.md missing (see README)"
  exit 1
}

check_no_placeholders ./visudo-report.md

emit_result skip "Report has no _____ placeholders; content quality is validated outside CI."
exit 0
