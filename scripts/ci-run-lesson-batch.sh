#!/usr/bin/env bash
# Run every exercise under one lesson on a single machine (CI batch mode).
# Concatenates per-exercise NDJSON lines into reports/.last-run.ndjson for one artifact upload.
# Usage: bash scripts/ci-run-lesson-batch.sh '<lesson folder basename>'
set -euo pipefail

LESSON_DIR="${1:?usage: ci-run-lesson-batch.sh <lesson folder basename>}"

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
export REPO_ROOT
cd "$REPO_ROOT"

mkdir -p reports

MATRIX_JSON="$(
  CI_DISCOVER_SCOPE=lesson_exercises CI_LESSON_DIR="$LESSON_DIR" \
    python3 "$REPO_ROOT/scripts/ci_discover_matrix.py"
)"

mapfile -t slugs < <(jq -r '.include[].exercise_slug' <<<"$MATRIX_JSON")

if ((${#slugs[@]} == 0)); then
  printf '%s\n' "ci-run-lesson-batch.sh: no exercises under lesson: $LESSON_DIR" >&2
  exit 1
fi

ACCUM="$REPO_ROOT/reports/.lesson-batch.ndjson"
rm -f "$ACCUM"
export SKIP_PROGRESS_REPORT=1

batch_fail=0
for slug in "${slugs[@]}"; do
  printf '\n━━ Lesson batch: %s / %s ━━\n' "$LESSON_DIR" "$slug"
  if ! RUN_LESSON_DIR="$LESSON_DIR" RUN_EXERCISE_SLUG="$slug" bash "$REPO_ROOT/scripts/run-all-tests.sh"; then
    batch_fail=1
  fi
  if [[ -s "$REPO_ROOT/reports/.last-run.ndjson" ]]; then
    cat "$REPO_ROOT/reports/.last-run.ndjson" >>"$ACCUM"
  fi
done

unset SKIP_PROGRESS_REPORT

mv "$ACCUM" "$REPO_ROOT/reports/.last-run.ndjson"

exit "$batch_fail"
