#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

emit_result skip "Not scored in CI (requires pre-created techstudent account and privileged group changes)"
exit 0
