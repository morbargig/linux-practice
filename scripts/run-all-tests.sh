#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
export REPO_ROOT
cd "$REPO_ROOT"

mkdir -p reports
NDJSON="$REPO_ROOT/reports/.last-run.ndjson"
if [[ -z "${RUN_APPEND_NDJSON:-}" ]]; then
  : >"$NDJSON"
fi

# Optional CI filters (basename of exercises/<lesson>/ only). RUN_EXERCISE_SLUG requires RUN_LESSON_DIR.
if [[ -n "${RUN_EXERCISE_SLUG:-}" && -z "${RUN_LESSON_DIR:-}" ]]; then
  printf '%s\n' "run-all-tests.sh: RUN_EXERCISE_SLUG requires RUN_LESSON_DIR" >&2
  exit 2
fi
if [[ -n "${RUN_LESSON_DIR:-}" ]]; then
  if [[ ! "$RUN_LESSON_DIR" =~ ^[0-9]{2}[[:space:]] ]]; then
    printf '%s\n' "run-all-tests.sh: RUN_LESSON_DIR must match lesson folder pattern (e.g. '01 — Topic')" >&2
    exit 2
  fi
  if [[ ! -d "$REPO_ROOT/exercises/$RUN_LESSON_DIR" ]]; then
    printf '%s\n' "run-all-tests.sh: RUN_LESSON_DIR not found under exercises/: $RUN_LESSON_DIR" >&2
    exit 2
  fi
fi

RUN_TS="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
STUDENT_ID="${PROGRESS_STUDENT_ID:-${GITHUB_ACTOR:-$(whoami)}}"

total_fail=0
total_pass=0
total_skip=0

append_ndjson() {
  local lesson_number="$1"
  local lesson_title="$2"
  local exercise_number="$3"
  local exercise_slug="$4"
  local rel_path="$5"
  local status="$6"
  local message="$7"

  jq -nc \
    --arg student "$STUDENT_ID" \
    --arg run_ts "$RUN_TS" \
    --argjson lesson_number "$lesson_number" \
    --arg lesson_title "$lesson_title" \
    --argjson exercise_number "$exercise_number" \
    --arg exercise_slug "$exercise_slug" \
    --arg path "$rel_path" \
    --arg status "$status" \
    --arg message "$message" \
    '{student_github_username:$student,last_run_utc:$run_ts,lesson_number:$lesson_number,lesson_title:$lesson_title,exercise_number:$exercise_number,exercise_slug:$exercise_slug,path:$path,status:$status,message:$message}' >>"$NDJSON"
}

run_one_test() {
  local test_script="$1"
  local lesson_number="$2"
  local lesson_title="$3"
  local exercise_number="$4"
  local exercise_slug="$5"
  local rel_path="${test_script#"$REPO_ROOT"/}"

  local ex_dir out exit_code result_line status msg

  ex_dir="$(dirname "$test_script")"
  pushd "$ex_dir" >/dev/null

  set +e
  out="$(bash ./test.sh 2>&1)"
  exit_code=$?
  set -e

  popd >/dev/null

  result_line="$(printf '%s\n' "$out" | grep '^RESULT ' | tail -n 1 || true)"
  if [[ -n "$result_line" ]]; then
    status="$(awk '{print $2}' <<<"$result_line")"
    msg="$(sed -e 's/^RESULT [^ ]* //' <<<"$result_line")"
  else
    status="fail"
    msg="Missing RESULT line from test.sh (exit $exit_code)"
    if [[ -n "$out" ]]; then
      msg+=" — $(printf '%s' "$out" | tail -c 200)"
    fi
    exit_code=1
  fi

  case "$status" in
    pass | skip) ;;
    fail) ;;
    *)
      status="fail"
      msg="Invalid RESULT status; $msg"
      exit_code=1
      ;;
  esac

  printf '%s\n' "$out"
  append_ndjson "$lesson_number" "$lesson_title" "$exercise_number" "$exercise_slug" "$rel_path" "$status" "$msg"

  if [[ "$status" == fail ]] || [[ "$exit_code" -ne 0 && "$status" != skip ]]; then
    ((total_fail++)) || true
    return 1
  fi
  if [[ "$status" == skip ]]; then
    ((total_skip++)) || true
  else
    ((total_pass++)) || true
  fi
  return 0
}

shopt -s nullglob

overall_fail=0
filtered_exercise_hit=0

for lesson_dir in "$REPO_ROOT"/exercises/*/; do
  [[ -d "$lesson_dir" ]] || continue

  lesson_basename="$(basename "$lesson_dir")"
  # Only lesson folders like "01 — Linux Fundamentals" (skip stray dirs such as nested copies of lab/)
  [[ "$lesson_basename" =~ ^[0-9]{2}[[:space:]] ]] || continue

  if [[ -n "${RUN_LESSON_DIR:-}" && "$lesson_basename" != "$RUN_LESSON_DIR" ]]; then
    continue
  fi

  lesson_number_str="$(printf '%s' "$lesson_basename" | sed -n 's/^\([0-9]\{1,\}\).*/\1/p')"
  # Strip leading decimal digits + whitespace + UTF-8 em dash (U+2014) + whitespace
  lesson_title_trim="$(printf '%s' "$lesson_basename" | sed $'s/^[0-9]\{1,\}[[:space:]]*\xe2\x80\x94[[:space:]]*//')"
  [[ -n "$lesson_title_trim" ]] || lesson_title_trim="$lesson_basename"

  lesson_number_json=$((10#${lesson_number_str:-0}))

  if [[ -z "${RUN_LESSON_DIR:-}" ]]; then
    printf '\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n'
    printf 'Lesson %s — %s\n' "$lesson_number_str" "$lesson_title_trim"
    printf '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n'
  else
    printf '\n── Filtered lesson %s — %s ──\n' "$lesson_number_str" "$lesson_title_trim"
  fi

  exercise_idx=0
  for ex_dir in "${lesson_dir}"*/; do
    [[ -d "$ex_dir" ]] || continue
    exercise_slug="$(basename "$ex_dir")"
    ((exercise_idx++)) || true

    if [[ -n "${RUN_EXERCISE_SLUG:-}" && "$exercise_slug" != "$RUN_EXERCISE_SLUG" ]]; then
      continue
    fi

    if [[ -n "${RUN_EXERCISE_SLUG:-}" ]]; then
      filtered_exercise_hit=1
    fi

    if [[ ! -f "${ex_dir}test.sh" ]]; then
      printf '⚠️  [%02d] %s — missing test.sh (skipped by harness)\n' "$exercise_idx" "$exercise_slug"
      append_ndjson "$lesson_number_json" "$lesson_title_trim" "$exercise_idx" "$exercise_slug" \
        "exercises/${lesson_basename}/${exercise_slug}/test.sh" "fail" "Missing test.sh"
      overall_fail=1
      ((total_fail++)) || true
      continue
    fi

    printf '\n── Exercise %02d: %s ──\n' "$exercise_idx" "$exercise_slug"
    if ! run_one_test "${ex_dir}test.sh" "$lesson_number_json" "$lesson_title_trim" "$exercise_idx" "$exercise_slug"; then
      overall_fail=1
      printf '→ status: FAIL\n'
    else
      printf '→ status: OK\n'
    fi
  done
done

if [[ -n "${RUN_EXERCISE_SLUG:-}" && "$filtered_exercise_hit" -eq 0 ]]; then
  printf '%s\n' "run-all-tests.sh: RUN_EXERCISE_SLUG not found under RUN_LESSON_DIR: ${RUN_EXERCISE_SLUG}" >&2
  exit 2
fi

printf '\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n'
printf 'Totals — passed: %s  skipped: %s  failed: %s\n' "$total_pass" "$total_skip" "$total_fail"
printf '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n'

if [[ -z "${SKIP_PROGRESS_REPORT:-}" ]]; then
  bash "$REPO_ROOT/scripts/generate-progress-report.sh"
fi

exit "$overall_fail"
