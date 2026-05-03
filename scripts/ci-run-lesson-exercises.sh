#!/usr/bin/env bash
# Run every exercise under one lesson on the CURRENT runner (ordered), merge NDJSON for CI upload.
# Requires: LESSON_DIR (basename under exercises/). Uses SKIP_PROGRESS_REPORT=1 per filtered harness call.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
export REPO_ROOT
cd "$REPO_ROOT"

LESSON_DIR="${LESSON_DIR:?missing LESSON_DIR}"
lesson_path="$REPO_ROOT/exercises/$LESSON_DIR"
[[ -d "$lesson_path" ]] || {
  printf '%s\n' "ci-run-lesson-exercises.sh: lesson dir not found: $lesson_path" >&2
  exit 2
}

mkdir -p reports
bundle="$REPO_ROOT/reports/.lesson-ci-bundle.ndjson"
: >"$bundle"

export SKIP_PROGRESS_REPORT=1

mapfile -t slugs < <(find "$lesson_path" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | LC_ALL=C sort)

overall_fail=0

for slug in "${slugs[@]}"; do
  echo "::group::Exercise $slug"
  set +e
  RUN_LESSON_DIR="$LESSON_DIR" RUN_EXERCISE_SLUG="$slug" bash scripts/run-all-tests.sh
  ec=$?
  set -e
  echo "::endgroup::"

  if [[ "$ec" -ne 0 ]]; then
    overall_fail=1
  fi

  if [[ -s "$REPO_ROOT/reports/.last-run.ndjson" ]]; then
    cat "$REPO_ROOT/reports/.last-run.ndjson" >>"$bundle"
  fi
done

mv -f "$bundle" "$REPO_ROOT/reports/.last-run.ndjson"

exit "$overall_fail"
