#!/usr/bin/env python3
"""Emit GitHub Actions dynamic matrix JSON for exercise CI.

Reads CI_MATRIX_GRANULARITY: "lesson" | "exercise" (default from caller)
Writes JSON to $GITHUB_OUTPUT key matrix (multiline) or stdout if unset.

Each row includes job_title for a clear lesson -> exercise hierarchy in the Actions UI.

Lesson title trimming mirrors scripts/run-all-tests.sh (digits + U+2014 em dash).
"""

from __future__ import annotations

import json
import os
import re
from pathlib import Path

LESSON_DIR_RE = re.compile(r"^(\d{2})\s")
# Leading lesson number + optional space + em dash (U+2014) + optional space
LESSON_TITLE_PREFIX = re.compile(r"^\d+\s*\u2014\s*")


def repo_root() -> Path:
    for key in ("GITHUB_WORKSPACE", "CI_REPO_ROOT"):
        raw = os.environ.get(key)
        if raw:
            return Path(raw).resolve()
    return Path(__file__).resolve().parents[1]


def truncate_title(title: str, max_len: int = 48) -> str:
    t = title.strip()
    if len(t) <= max_len:
        return t
    if max_len < 2:
        return t[:max_len]
    return t[: max_len - 1] + "…"


def lesson_num_and_title(lesson_dir: str) -> tuple[str, str]:
    """Return (two_digit_lesson_prefix, trimmed human title) matching run-all-tests.sh."""
    m = LESSON_DIR_RE.match(lesson_dir)
    if not m:
        return ("00", truncate_title(lesson_dir))
    num = m.group(1)
    trimmed = LESSON_TITLE_PREFIX.sub("", lesson_dir)
    if trimmed == lesson_dir:
        trimmed = re.sub(r"^\d+\s+", "", lesson_dir).strip()
    if not trimmed:
        trimmed = lesson_dir
    return (num, truncate_title(trimmed))


def job_title_lesson(num: str, title: str) -> str:
    return f"{num} · {title} · all exercises"


def job_title_exercise(num: str, title: str, slug: str) -> str:
    return f"{num} · {title} › {slug}"


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
        lesson_dir = lesson_path.name
        num, title = lesson_num_and_title(lesson_dir)

        if granularity == "lesson":
            include.append(
                {
                    "key": f"{num}__lesson",
                    "lesson_dir": lesson_dir,
                    "exercise_slug": "",
                    "job_title": job_title_lesson(num, title),
                }
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
                    "job_title": job_title_exercise(num, title, slug),
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
