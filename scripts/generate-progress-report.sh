#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
NDJSON="$ROOT/reports/.last-run.ndjson"
OUT_JSON="$ROOT/reports/progress.json"
OUT_MD="$ROOT/reports/progress-report.md"

if [[ ! -s "$NDJSON" ]]; then
  echo "No results at $NDJSON — run scripts/run-all-tests.sh first." >&2
  exit 1
fi

jq -s '
  sort_by(.lesson_number, .exercise_number)
  | . as $rows
  | ($rows[0].student_github_username // "unknown") as $stu
  | ($rows[0].last_run_utc // "") as $ts
  | ([.[] | select(.status=="pass")] | length) as $pass
  | ([.[] | select(.status=="fail")] | length) as $fail
  | ([.[] | select(.status=="skip")] | length) as $skip
  | ([.[] | select(.status!="skip")] | length) as $graded
  | (if ($graded > 0) then (($pass / $graded) * 100 | . * 100 | round / 100) else 0 end) as $pct
  | ($rows
      | group_by(.lesson_number)
      | map(sort_by(.exercise_number))
      | map({
          lesson_number: .[0].lesson_number,
          lesson_title: .[0].lesson_title,
          exercises: map({
            exercise_number,
            exercise_slug,
            status,
            message,
            path,
            last_run_utc
          })
        })
    ) as $lessons
  | ($rows | map({
      student_github_username: .student_github_username,
      lesson_number,
      exercise_number,
      exercise_slug,
      status,
      last_run_utc,
      message,
      path
    })) as $dash
  | {
      student_github_username: $stu,
      last_run_utc: $ts,
      summary: {
        passed: $pass,
        failed: $fail,
        skipped: $skip,
        graded_total: $graded,
        percent: $pct
      },
      lessons: $lessons,
      dashboard_rows: $dash
    }
  ' "$NDJSON" >"$OUT_JSON"

jq -r '
  "# Exercise progress report\n",
  "",
  "| Field | Value |",
  "| --- | --- |",
  "| Student (GitHub / override) | `\(.student_github_username)` |",
  "| Last run (UTC) | `\(.last_run_utc)` |",
  "| Passed | \(.summary.passed) |",
  "| Failed | \(.summary.failed) |",
  "| Skipped (not graded) | \(.summary.skipped) |",
  "| Graded total (pass + fail) | \(.summary.graded_total) |",
  "| **Overall progress %** | **\(.summary.percent)%** |",
  "",
  "## Dashboard rows",
  "",
  "| Student | Lesson | Exercise # | Slug | Status | Last run (UTC) |",
  "| --- | ---: | ---: | --- | --- | --- |",
  (.dashboard_rows[] | "| `\(.student_github_username)` | \(.lesson_number) | \(.exercise_number) | \(.exercise_slug) | **\(.status)** | `\(.last_run_utc)` |"),
  "",
  "## By lesson",
  ""
  ' "$OUT_JSON" >"$OUT_MD.tmp"

{
  jq -r '
    .lessons[] |
    "### Lesson \(.lesson_number): \(.lesson_title)\n\n",
    "| Ex # | Slug | Status | Notes |",
    "| ---: | --- | --- | --- |",
    (.exercises[] | "| \(.exercise_number) | \(.exercise_slug) | **\(.status)** | \(.message | gsub("\\|"; "\\|")) |"),
    ""
    ' "$OUT_JSON"
} >>"$OUT_MD.tmp"

mv "$OUT_MD.tmp" "$OUT_MD"

echo "Wrote $OUT_JSON and $OUT_MD"
