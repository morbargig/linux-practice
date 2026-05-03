#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

check_no_placeholders ./backup.sh

bash_syntax_ok ./backup.sh || {
  emit_result fail "bash -n failed on backup.sh"
  exit 1
}

src="../../lab/files"

set +e
out="$(bash ./backup.sh "$src" 2>&1)"
ec=$?
set -e

[[ "$ec" -eq 0 ]] || {
  emit_result fail "backup.sh should succeed against ../../lab/files"
  exit 1
}

printf '%s' "$out" | grep -qF 'Backup completed!' || {
  emit_result fail "backup.sh should announce Backup completed!"
  exit 1
}

printf '%s' "$out" | grep -qi 'backup.log' || {
  emit_result fail "backup.sh should mention backup.log location"
  exit 1
}

emit_result pass "backup.sh completes backup pipeline"
exit 0
