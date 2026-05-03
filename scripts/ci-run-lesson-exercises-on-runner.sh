#!/usr/bin/env bash
# Run every exercise under one lesson on this runner only (ordered slugs).
# Accumulates NDJSON lines into reports/.last-run.ndjson for one artifact upload.
# Env: LESSON_DIR (basename), PROGRESS_STUDENT_ID optional.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

LESSON_DIR="${LESSON_DIR:?Set LESSON_DIR to lesson folder basename}"

mkdir -p reports
accum="$REPO_ROOT/reports/.lesson-ci-accum.ndjson"
: >"$accum"

overall_fail=0

while IFS= read -r slug; do
  [[ -z "$slug" ]] && continue
  echo "::group::Exercise $slug"
  set +e
  SKIP_PROGRESS_REPORT=1 \
    RUN_LESSON_DIR="$LESSON_DIR" \
    RUN_EXERCISE_SLUG="$slug" \
    PROGRESS_STUDENT_ID="${PROGRESS_STUDENT_ID:-${GITHUB_ACTOR:-$(whoami)}}" \
    bash "$REPO_ROOT/scripts/run-all-tests.sh"
  ec=$?
  set -e
  echo "::endgroup::"

  if [[ -s "$REPO_ROOT/reports/.last-run.ndjson" ]]; then
    cat "$REPO_ROOT/reports/.last-run.ndjson" >>"$accum"
  fi

  if [[ "$ec" -ne 0 ]]; then
    overall_fail=1
  fi
done < <("$REPO_ROOT/scripts/ci-lesson-exercise-slugs.sh" "$LESSON_DIR")

mv "$accum" "$REPO_ROOT/reports/.last-run.ndjson"

exit "$overall_fail"
