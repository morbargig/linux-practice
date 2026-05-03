#!/usr/bin/env bash
# Append a Markdown "By lesson" overview to $GITHUB_STEP_SUMMARY from progress.json.
# Usage: bash scripts/ci-append-lesson-overview-to-summary.sh [path/to/progress.json]
# No-op if file missing or jq unavailable (CI installs jq before calling).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
JSON="${1:-$ROOT/reports/progress.json}"

if [[ ! -f "$JSON" ]]; then
  exit 0
fi

if ! command -v jq >/dev/null 2>&1; then
  exit 0
fi

target="${GITHUB_STEP_SUMMARY:-}"
if [[ -z "$target" ]]; then
  target="/dev/stdout"
fi

jq -r '
  "",
  "### By lesson",
  "",
  (.lessons | sort_by(.lesson_number) | .[] |
    ("#### Lesson \(.lesson_number) — \(.lesson_title)"),
    "",
    "| # | Exercise | Status |",
    "| :--- | :--- | :--- |",
    (.exercises[] | "| \(.exercise_number) | `\(.exercise_slug)` | **\(.status)** |"),
    ""
  )
' "$JSON" >>"$target"
