#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

emit_result skip "Manual-only exercise (UFW/sudo); no automated scoring per README"
exit 0
