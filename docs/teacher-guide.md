# Teacher guide — progress reports and extending the course

This repository uses **co-located Bash tests** (`exercises/**/<exercise>/test.sh`), an aggregator (`scripts/run-all-tests.sh`), and **Markdown + JSON reports** suitable for archives or a future dashboard—no web application.

## Where progress data appears

Every CI run (and every successful local `scripts/run-all-tests.sh`) produces:

| Output | Purpose |
| --- | --- |
| `reports/progress-report.md` | Printable/email-friendly Markdown tables |
| `reports/progress.json` | Machine-readable summary + `dashboard_rows` |
| `reports/.last-run.ndjson` | One JSON record per exercise (intermediate; handy for debugging) |

These paths are listed in `.gitignore` so students do not accidentally commit scores; **`reports/.gitkeep`** preserves the folder in Git.

### Downloading reports from GitHub Actions

1. Open **Actions → Exercise tests**.
2. Select a workflow run for the student’s fork/branch.
3. Download the **`progress-reports`** artifact (contains `progress-report.md` and `progress.json`).
4. Optionally read the generated **job summary** on the run page for a one-line pass/skip/fail overview.

Repeat per student fork (or integrate artifacts into your LMS later using `progress.json`).

## Reading `progress.json`

Top-level fields:

- `student_github_username` — `github.actor` in CI, or `PROGRESS_STUDENT_ID`, or local `whoami`.
- `last_run_utc` — timestamp applied to each row for that run.
- `summary.passed`, `summary.failed`, `summary.skipped`, `summary.graded_total`, `summary.percent`
- `lessons[]` — grouped exercises with messages and paths.
- `dashboard_rows[]` — flat list aligned with the columns you requested: **student, lesson #, exercise #, slug, status, last_run_utc, message, path**.

### Overall percentage

`summary.percent` is `passed / graded_total * 100`, where `graded_total = passed + failed`.

**Skipped** exercises do not count toward the denominator. They are documented, not graded, in CI.

### Exercises that `skip` today

| Location | Reason |
| --- | --- |
| `03-create-user` | Interactive `passwd` / destructive provisioning |
| `04-groups-membership` | Expects pre-seeded accounts and privileged group edits |
| `06-sudoers-safe` | README-only; no `*.sh` deliverable in-repo |
| `05-routing-and-gateway` | Skips automatically if `/usr/sbin/ip` is missing (common on macOS); runs on Ubuntu CI |
| `06-firewall-basics` | Manual UFW inspection by design |

Adjust the corresponding `test.sh` if your class policy differs.

## How tests work

1. **`scripts/run-all-tests.sh`** walks `exercises/<lesson>/<exercise>/` in sorted order.
2. Each **`test.sh`** must print **exactly one machine-readable summary line** to stdout:

   ```
   RESULT pass|fail|skip Human-readable explanation
   ```

3. Shared helpers live in **`scripts/test-lib.sh`** (`emit_result`, placeholder checks, etc.).
4. **Lesson 05** exercises validate **`task.sh`** network summaries; most earlier lessons validate student scripts (`*.sh` excluding `test.sh` / `task.sh`).
5. **`scripts/run-all-tests.sh`** only descends immediate children of **`exercises/`** whose names match **`^[0-9]{2}[[:space:]]`** (two digits, then whitespace). Keep lesson folders under that pattern and avoid unrelated sibling directories at the same level.

## Repository layout

- **`exercises/lab`** is a symlink to **`lab/`** at the repo root so starter scripts using `../../lab/...` resolve correctly from exercise folders. Preserve this symlink when restructuring files.
- Several exercises recreate scratch files under **`lab/`** (permissions drills, awk samples, backups). Matching paths are **`gitignore`d** so local runs do not clutter `git status`.

## Branch policy (maintainers)

- **`main`** is the **unresolved** student template (TODOs / `_____` placeholders). Learners fork or clone from **`main`**; CI on **`main`** is expected to fail until work is finished (aside from deliberate **skip** tests).
- **Do not merge** reference or solution branches into **`main`** for repos handed to students. Keep worked answers on a **separate branch or private fork**, rebasing onto **`main`** whenever the template changes—same pattern as an instructor-only “always-green baseline” branch mentioned under Troubleshooting.

## CI matrix (GitHub Actions)

The **Exercise tests** workflow (`.github/workflows/exercise-tests.yml`) is split for a clear Actions UI:

| Job | Role |
| --- | --- |
| **discover** | Runs [`scripts/ci-discover-matrix.sh`](scripts/ci-discover-matrix.sh) (Python helper) to scan `exercises/` with the **same** lesson naming rule as [`scripts/run-all-tests.sh`](scripts/run-all-tests.sh) (`^[0-9]{2}[[:space:]]`…). Writes a dynamic `matrix` output—**no workflow edits** when you add lessons or exercise folders. |
| **test_matrix** | Ubuntu matrix jobs with **`max-parallel: 1`** so only **one cell runs at a time**, roughly following discovery order (sorted lesson folders, then sorted exercise folders). `fail-fast: false` still runs remaining cells after a failure. Each cell sets **`RUN_LESSON_DIR`** and, in *exercise* mode, **`RUN_EXERCISE_SLUG`**, then runs `bash scripts/run-all-tests.sh`. **Job names** use **`job_title`** (readable *lesson → exercise*). **`key`** is a short ASCII id for NDJSON artifact names (`matrix-ndjson-…`). |
| **aggregate_reports** | Downloads all `matrix-ndjson-*` fragments, merges `.last-run.ndjson` lines, runs [`scripts/generate-progress-report.sh`](scripts/generate-progress-report.sh), uploads **`progress-reports`**, prints a combined summary, and appends **By lesson** tables via [`scripts/ci-append-lesson-overview-to-summary.sh`](scripts/ci-append-lesson-overview-to-summary.sh). |
| **enforce_success** | Fails the workflow if **any** matrix cell failed (aggregate still runs via `if: always()` so you keep partial reports). |

**Presentation**

- Jobs sort naturally by lesson number at the start of **`job_title`** (`02 · …` before `03 · …`).
- **Lesson** mode ends titles with **`· all exercises`**; **exercise** mode adds **`›`** and the exercise folder name after the trimmed lesson title (derived from the lesson folder name; very long titles are shortened).

**Granularity**

- **Push / pull_request** runs default to **`lesson`** (one matrix cell per lesson folder; fewer cells than exercise mode; **`test_matrix`** runs cells **one after another**, not concurrently).
- **workflow_dispatch → Run workflow** offers **`lesson`** or **`exercise`** (one job per exercise folder for the clearest lesson → exercise map; sequential runs increase wall-clock time vs full parallel).

Only one **test_matrix** cell runs at a time, so workspaces are isolated per cell and you avoid concurrent writes to shared `lab/` paths across CI jobs (local parallel mode is not used in this workflow).

**Local filtered run** (matches what CI passes per cell):

```bash
RUN_LESSON_DIR='01 — Linux Fundamentals' RUN_EXERCISE_SLUG='03-find' bash scripts/run-all-tests.sh
```

Omit **`RUN_EXERCISE_SLUG`** to execute every exercise under that lesson.

## Adding a new exercise

1. Create **`exercises/<NN — Lesson>/<mm-slug>/`** with README + starter scripts (keep `_____` placeholders if you want CI to fail until completion).
2. Add **`test.sh`** beside the student scripts.
   - Source `"$REPO_ROOT/scripts/test-lib.sh"`.
   - Call `check_no_placeholders` on every file students must finish.
   - End with `emit_result …` and `exit 0` for **pass/skip**, `exit 1` after **`RESULT fail`** if you want the harness to record failure while still emitting the RESULT line (the aggregator treats `fail` + non-zero exit as failure).

3. Update lesson README counts/hours if you maintain them.

4. Run locally:

   ```bash
   bash scripts/setup.sh
   bash scripts/run-all-tests.sh
   ```

5. Commit and push; **Exercise tests** runs automatically when `exercises/**`, `scripts/**`, or the workflow changes. CI discovers lessons/exercises dynamically (see **CI matrix** above).

## Troubleshooting

- **Empty `reports/.last-run.ndjson` / missing reports** — ensure `jq` is installed; rerun `scripts/run-all-tests.sh`.
- **False fails on student laptops** — remind students that CI is **Ubuntu**; WSL2 or a container reduces drift.
- **Red CI while placeholders remain** — unfinished starters still contain `_____`; see **Branch policy** above. Keep an instructor-only branch or fork when you need an always-green baseline for comparison.
- **Want stricter/softer grading** — edit the exercise’s `test.sh` assertions; avoid changing the `RESULT …` contract without updating `scripts/run-all-tests.sh`.
