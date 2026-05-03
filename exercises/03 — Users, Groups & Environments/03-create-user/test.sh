#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

emit_result skip "Not scored in CI (interactive passwd / destructive user provisioning)"
exit 0
