#!/usr/bin/env bash
# Emit dynamic GitHub Actions matrix JSON for exercise CI.
#
# CI_DISCOVER_SCOPE:
#   root_lessons    — one row per lesson (default); root workflow discover step.
#   lesson_exercises — rows per exercise under CI_LESSON_DIR; reusable lesson suite.
#
# Env passthrough: CI_REPO_ROOT, CI_DISCOVER_SCOPE, CI_LESSON_DIR, GITHUB_OUTPUT.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
export CI_REPO_ROOT="$ROOT"

exec python3 "$ROOT/scripts/ci_discover_matrix.py"
