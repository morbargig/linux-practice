#!/usr/bin/env python3
"""Emit GitHub Actions dynamic matrix JSON for exercise CI.

CI_DISCOVER_SCOPE:
  root_lessons (default) — one matrix row per lesson folder (invokes nested suite per lesson).
  lesson_exercises — requires CI_LESSON_DIR (basename); one row per exercise under that lesson.

Writes $GITHUB_OUTPUT key matrix (multiline) or stdout if unset.

Each row includes job_title (lesson → exercise). Keys stay stable for NDJSON artifact names.

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


def emit_matrix(include: list[dict[str, str]]) -> None:
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


def scope_root_lessons(exercises: Path) -> list[dict[str, str]]:
    include: list[dict[str, str]] = []
    for lesson_path in sorted(exercises.iterdir()):
        if not lesson_path.is_dir():
            continue
        if not LESSON_DIR_RE.match(lesson_path.name):
            continue
        lesson_dir = lesson_path.name
        num, title = lesson_num_and_title(lesson_dir)
        include.append(
            {
                "key": f"{num}__lesson",
                "lesson_dir": lesson_dir,
                "exercise_slug": "",
                "job_title": job_title_lesson(num, title),
            }
        )
    return include


def scope_lesson_exercises(exercises: Path, lesson_dir: str) -> list[dict[str, str]]:
    lesson_path = exercises / lesson_dir
    if not lesson_path.is_dir():
        raise SystemExit(f"CI_LESSON_DIR not found under exercises/: {lesson_dir!r}")

    if not LESSON_DIR_RE.match(lesson_dir):
        raise SystemExit(f"CI_LESSON_DIR must match lesson folder pattern (NN — Topic): {lesson_dir!r}")

    num, title = lesson_num_and_title(lesson_dir)
    include: list[dict[str, str]] = []
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
    return include


def main() -> None:
    scope = os.environ.get("CI_DISCOVER_SCOPE", "root_lessons").strip().lower()
    if scope not in ("root_lessons", "lesson_exercises"):
        raise SystemExit(f"Invalid CI_DISCOVER_SCOPE={scope!r}; expected root_lessons or lesson_exercises")

    exercises = repo_root() / "exercises"
    if not exercises.is_dir():
        raise SystemExit(f"Missing exercises directory: {exercises}")

    if scope == "root_lessons":
        include = scope_root_lessons(exercises)
    else:
        lesson_dir = os.environ.get("CI_LESSON_DIR", "").strip()
        if not lesson_dir:
            raise SystemExit("lesson_exercises scope requires CI_LESSON_DIR (lesson folder basename)")
        include = scope_lesson_exercises(exercises, lesson_dir)

    emit_matrix(include)


if __name__ == "__main__":
    main()
