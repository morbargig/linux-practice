#!/usr/bin/env bash
# Print sorted exercise folder basenames under exercises/<lesson>/ (directories only).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LESSON="${1:?usage: ci-lesson-exercise-slugs.sh <lesson_dir_basename>}"

DIR="$ROOT/exercises/$LESSON"
[[ -d "$DIR" ]] || {
  printf '%s\n' "Lesson directory not found: exercises/$LESSON" >&2
  exit 1
}

shopt -s nullglob
for path in "$DIR"/*/; do
  [[ -d "$path" ]] || continue
  basename "$path"
done | LC_ALL=C sort
