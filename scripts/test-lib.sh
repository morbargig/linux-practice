#!/usr/bin/env bash
# Shared helpers for exercise test.sh scripts (source after setting strict mode if desired).

# Resolve repository root (run-all-tests sets REPO_ROOT).
repo_root() {
  if [[ -n "${REPO_ROOT:-}" ]]; then
    printf '%s\n' "$REPO_ROOT"
  elif [[ -n "${GITHUB_WORKSPACE:-}" ]]; then
    printf '%s\n' "$GITHUB_WORKSPACE"
  elif git rev-parse --show-toplevel >/dev/null 2>&1; then
    git rev-parse --show-toplevel
  else
    pwd
  fi
}

# List *.sh in dir excluding test.sh and task.sh (student deliverables).
student_shell_scripts_in_dir() {
  local dir="${1:-.}"
  local f base
  shopt -s nullglob
  for f in "$dir"/*.sh; do
    base="$(basename "$f")"
    [[ "$base" == test.sh ]] && continue
    [[ "$base" == task.sh ]] && continue
    printf '%s\n' "$f"
  done
}

# Fail via RESULT line + exit 1 if any file contains _____ placeholders.
check_no_placeholders() {
  local f
  for f in "$@"; do
    [[ -f "$f" ]] || continue
    if grep -q '_____' "$f" 2>/dev/null; then
      emit_result fail "Incomplete: _____ placeholder remains in $(basename "$f")"
      exit 1
    fi
  done
}

# Non-zero return if bash -n fails for any file.
bash_syntax_ok() {
  local f
  for f in "$@"; do
    [[ -f "$f" ]] || continue
    bash -n "$f" 2>/dev/null || return 1
  done
  return 0
}

# Emit machine-readable line consumed by scripts/run-all-tests.sh (must be one line).
emit_result() {
  local status="$1"
  shift
  local msg="${*:-}"
  msg="${msg//$'\n'/ }"
  msg="${msg//$'\r'/}"
  printf 'RESULT %s %s\n' "$status" "$msg"
}

# Run a script from its directory; capture merged stdout/stderr.
run_script_capture() {
  local script_path="$1"
  shift
  local d sb
  d="$(cd "$(dirname "$script_path")" && pwd)"
  sb="$(basename "$script_path")"
  ( cd "$d" && bash "./$sb" "$@" ) 2>&1
}
