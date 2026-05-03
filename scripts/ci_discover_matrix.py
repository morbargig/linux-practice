#!/usr/bin/env python3
"""Emit GitHub Actions dynamic matrix JSON for exercise CI.

Reads CI_MATRIX_GRANULARITY: "lesson" | "exercise" (default from caller)
Writes JSON to $GITHUB_OUTPUT key matrix (multiline) or stdout if unset.

Lesson/exercise detection mirrors scripts/run-all-tests.sh:
only immediate children of exercises/ matching ^\\d{2}\\s
"""

from __future__ import annotations

import json
import os
import re
from pathlib import Path

LESSON_DIR_RE = re.compile(r"^(\d{2})\s")


def repo_root() -> Path:
    for key in ("GITHUB_WORKSPACE", "CI_REPO_ROOT"):
        raw = os.environ.get(key)
        if raw:
            return Path(raw).resolve()
    return Path(__file__).resolve().parents[1]


def main() -> None:
    granularity = os.environ.get("CI_MATRIX_GRANULARITY", "lesson").strip().lower()
    if granularity not in ("lesson", "exercise"):
        raise SystemExit(f"Invalid CI_MATRIX_GRANULARITY={granularity!r}; expected lesson or exercise")

    exercises = repo_root() / "exercises"
    if not exercises.is_dir():
        raise SystemExit(f"Missing exercises directory: {exercises}")

    include: list[dict[str, str]] = []

    for lesson_path in sorted(exercises.iterdir()):
        if not lesson_path.is_dir():
            continue
        m = LESSON_DIR_RE.match(lesson_path.name)
        if not m:
            continue
        num = m.group(1)
        lesson_dir = lesson_path.name

        if granularity == "lesson":
            include.append(
                {"key": f"{num}__lesson", "lesson_dir": lesson_dir, "exercise_slug": ""}
            )
            continue

        for ex_path in sorted(lesson_path.iterdir()):
            if not ex_path.is_dir():
                continue
            slug = ex_path.name
            include.append(
                {
                    "key": f"{num}__{slug}",
                    "lesson_dir": lesson_dir,
                    "exercise_slug": slug,
                }
            )

    matrix = {"include": include}
    payload = json.dumps(matrix, ensure_ascii=False)

    out_file = os.environ.get("GITHUB_OUTPUT")
    if out_file:
        with open(out_file, "a", encoding="utf-8") as fh:
            fh.write("matrix<<MATRIX_JSON_EOF\n")
            fh.write(payload)
            fh.write("\nMATRIX_JSON_EOF\n")
    else:
        print(payload)


if __name__ == "__main__":
    main()
