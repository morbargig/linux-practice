#!/bin/bash
set -e

echo "Running checks..."

fail() {
  echo "❌ $1"
  exit 1
}

pass() {
  echo "✅ $1"
}

warn() {
  echo "⚠️  $1"
}

# Check challenge script exists
[ -f "exercises/01 — Linux Fundamentals/09-challenge/analyzer.sh" ] || fail "Challenge script missing"

# Basic check: scripts should be executable or at least present
# Layout: exercises/<lesson>/<exercise-dir>/*.sh
shopt -s nullglob
scripts_found=0
for f in exercises/*/*/*.sh; do
  [ -f "$f" ] || fail "Missing: $f"
  scripts_found=$((scripts_found + 1))
done
[ "$scripts_found" -gt 0 ] || fail "No exercise scripts found under exercises/*/*/"
pass "All exercise scripts exist ($scripts_found files)"

# Check for TODO markers (should exist in incomplete exercises)
echo ""
echo "Checking for TODO markers..."

# Exercises that should have TODOs (students need to complete)
exercises_with_todos=(
  "exercises/01 — Linux Fundamentals/01-tools/tasks.sh"
  "exercises/01 — Linux Fundamentals/02-vscode-bash/hello.sh"
  "exercises/01 — Linux Fundamentals/03-find/find_basic.sh"
  "exercises/01 — Linux Fundamentals/03-find/find_advanced.sh"
  "exercises/01 — Linux Fundamentals/04-loops/for_loop.sh"
  "exercises/01 — Linux Fundamentals/04-loops/while_loop.sh"
  "exercises/01 — Linux Fundamentals/05-if-else/conditions.sh"
  "exercises/01 — Linux Fundamentals/06-find-plus-loop/process_logs.sh"
  "exercises/01 — Linux Fundamentals/07-first-script/cleanup.sh"
  "exercises/01 — Linux Fundamentals/08-debugging/debug_me.sh"
  "exercises/01 — Linux Fundamentals/09-challenge/analyzer.sh"
  "exercises/01 — Linux Fundamentals/10-basic-commands/basic_commands.sh"
  "exercises/02 — Bash, Find, Loops & Scripting/01-file-operations/file_ops.sh"
  "exercises/02 — Bash, Find, Loops & Scripting/02-grep-text/grep_search.sh"
  "exercises/02 — Bash, Find, Loops & Scripting/03-variables-arrays/variables.sh"
  "exercises/02 — Bash, Find, Loops & Scripting/04-functions/functions.sh"
  "exercises/02 — Bash, Find, Loops & Scripting/05-piping-redirection/piping.sh"
  "exercises/02 — Bash, Find, Loops & Scripting/06-advanced-find/advanced_find.sh"
  "exercises/02 — Bash, Find, Loops & Scripting/07-error-handling/error_handling.sh"
  "exercises/02 — Bash, Find, Loops & Scripting/08-sed-basics/sed_basics.sh"
  "exercises/02 — Bash, Find, Loops & Scripting/09-final-project/backup.sh"
)

# Check if scripts are executable
for f in exercises/*/*/*.sh; do
  if [ ! -x "$f" ]; then
    warn "$f is not executable (run: chmod +x $f)"
  fi
done

# Validate exercise completion status
echo ""
echo "Checking exercise completion status..."

incomplete_count=0
complete_count=0

for exercise in "${exercises_with_todos[@]}"; do
  if [ -f "$exercise" ]; then
    if grep -q "_____" "$exercise" 2>/dev/null; then
      incomplete_count=$((incomplete_count + 1))
    else
      complete_count=$((complete_count + 1))
    fi
  fi
done

if [ $incomplete_count -gt 0 ]; then
  echo "📝 Incomplete exercises: $incomplete_count (still have _____ placeholders)"
fi

if [ $complete_count -gt 0 ]; then
  echo "✅ Completed exercises: $complete_count"
fi

# Check specific exercises for TODO markers
echo ""
echo "Exercise status:"
for exercise in "${exercises_with_todos[@]}"; do
  if [ -f "$exercise" ]; then
    if grep -q "_____" "$exercise" 2>/dev/null; then
      echo "  ⏳ $(basename "$(dirname "$exercise")")/$(basename "$exercise") - needs completion"
    else
      echo "  ✅ $(basename "$(dirname "$exercise")")/$(basename "$exercise") - completed"
    fi
  fi
done

# Check that lab files exist
if [ -d "lab/files" ]; then
  pass "Lab files directory exists"
else
  warn "Lab files not found. Run: ./scripts/setup.sh"
fi

echo ""
echo "Checks completed ✅"
echo ""
echo "To test exercises, run them individually from their directories."
