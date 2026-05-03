#!/usr/bin/env bash
# Emit dynamic GitHub Actions matrix JSON (lesson-level or per-exercise cells).
# Uses CI_MATRIX_GRANULARITY=lesson|exercise (default: lesson via workflow env).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
export CI_REPO_ROOT="$ROOT"

exec python3 "$ROOT/scripts/ci_discover_matrix.py"
