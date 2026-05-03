#!/usr/bin/env bash
# Run every exercise under LESSON_DIR in sorted order on ONE runner:
# one APT/tooling install, lab tarball extracted fresh before each exercise.
#
# Env:
#   MATRIX_JSON — JSON from discover_exercises.outputs.matrix (include[].exercise_slug)
#   LESSON_DIR — lesson folder basename under exercises/
#   LAB_ARCHIVE — path to lesson-lab.tgz (default: downloaded/lesson-lab.tgz under repo root)
#   PROGRESS_STUDENT_ID — optional (passed through to run-all-tests.sh)
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

: "${MATRIX_JSON:?MATRIX_JSON is required}"
: "${LESSON_DIR:?LESSON_DIR is required}"

LAB_ARCHIVE="${LAB_ARCHIVE:-downloaded/lesson-lab.tgz}"
if [[ "$LAB_ARCHIVE" != /* ]]; then
  LAB_ARCHIVE="$ROOT/$LAB_ARCHIVE"
fi

if [[ ! -f "$LAB_ARCHIVE" ]]; then
  printf '%s\n' "ci-run-lesson-exercises-sequential.sh: lab tarball not found: $LAB_ARCHIVE" >&2
  exit 2
fi

mapfile -t slugs < <(
  MATRIX_JSON="$MATRIX_JSON" python3 - <<'PY'
import json
import os

raw = os.environ["MATRIX_JSON"]
m = json.loads(raw)
rows = m.get("include") or []
for row in rows:
    slug = (row.get("exercise_slug") or "").strip()
    if slug:
        print(slug)
PY
)

if ((${#slugs[@]} == 0)); then
  printf '%s\n' "ci-run-lesson-exercises-sequential.sh: no exercises in MATRIX_JSON.include" >&2
  exit 2
fi

mkdir -p reports
: >"$ROOT/reports/.last-run.ndjson"

overall_fail=0
for slug in "${slugs[@]}"; do
  rm -rf "$ROOT/lab"
  tar xzf "$LAB_ARCHIVE" -C "$ROOT"

  export RUN_LESSON_DIR="$LESSON_DIR"
  export RUN_EXERCISE_SLUG="$slug"
  export SKIP_PROGRESS_REPORT=1
  export RUN_APPEND_NDJSON=1

  printf '\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n'
  printf 'CI sequential — %s › %s\n' "$LESSON_DIR" "$slug"
  printf '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n'

  if ! bash "$ROOT/scripts/run-all-tests.sh"; then
    overall_fail=1
  fi
done

exit "$overall_fail"
