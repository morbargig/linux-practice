#!/usr/bin/env bash
set -euo pipefail
: "${REPO_ROOT:?}"
# shellcheck source=scripts/test-lib.sh
source "$REPO_ROOT/scripts/test-lib.sh"

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

check_no_placeholders ./functions.sh

bash_syntax_ok ./functions.sh || {
  emit_result fail "bash -n failed on functions.sh"
  exit 1
}

set +e
out="$(bash ./functions.sh 2>&1)"
ec=$?
set -e

[[ "$ec" -eq 0 ]] || {
  emit_result fail "functions.sh should exit successfully"
  exit 1
}

printf '%s' "$out" | grep -qF 'Hello from function!' || {
  emit_result fail 'functions.sh should print Hello from function!'
  exit 1
}

printf '%s' "$out" | grep -q 'Log file has' || {
  emit_result fail 'functions.sh should report Log file has … lines'
  exit 1
}

emit_result pass "functions.sh exercises greet/count/size helpers"
exit 0
