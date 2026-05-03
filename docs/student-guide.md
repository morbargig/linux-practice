# Student guide — running tests and submitting work

This course repo grades exercises with **Bash tests** (`test.sh` in each exercise folder) plus GitHub Actions on Ubuntu.

## Recommended environment (important)

Run the labs on **Ubuntu** so your machine matches CI (**`ubuntu-latest`**).

Good options:

- **Ubuntu** desktop/server or VM (including Multipass, UTM, VirtualBox).
- **WSL2** with an Ubuntu distro on Windows (preferred over plain Git Bash).
- **GitHub Codespaces** or another cloud VM on Ubuntu.

macOS can run many scripts, but tools and paths differ (`ip` vs `ifconfig`, BSD vs GNU `find`/`sed`, etc.), so you may see failures locally that **do not** appear in Actions—or the opposite. Treat **Ubuntu / WSL2** as the reference environment.

## Prerequisites

- **Ubuntu (native or WSL2)** — strongly recommended (see above).
- **Bash**, **Git**, and **`jq`** (the harness writes `reports/.last-run.ndjson` and builds JSON/Markdown reports).
  - Debian/Ubuntu: `sudo apt install jq tree`
  - macOS (Homebrew): `brew install jq` (install `tree` if an exercise asks for it)

## Local workflow

1. **Clone your fork** (or the class template) and enter the repo root.

2. **Create lab fixtures** (required for many lessons):

   ```bash
   bash scripts/setup.sh
   ```

3. **Run every exercise test** and generate reports:

   ```bash
   bash scripts/run-all-tests.sh
   ```

   - The script prints **per-lesson headers** and **PASS / FAIL / SKIP** style results.
   - It writes:
     - `reports/.last-run.ndjson` — one JSON object per exercise (input for reports)
     - `reports/progress.json` — summary + dashboard-oriented rows
     - `reports/progress-report.md` — human-readable tables
   - Exit code **0** only when **no exercise is `fail`**. **`skip` does not fail the run.**

4. **Identify yourself in local reports** (optional). By default the report uses `GITHUB_ACTOR` in CI and your **`whoami`** name locally. To mimic a GitHub username:

   ```bash
   PROGRESS_STUDENT_ID=your-github-username bash scripts/run-all-tests.sh
   ```

## Understanding results

- **`fail`** — usually either `_____` placeholders left in your script or the behavior checks did not match the README expectations.
- **`skip`** — exercise is intentionally not auto-graded (for example manual UFW work, README-only labs, or CI-only constraints). Skips are **excluded** from the percentage in `progress.json`.

## Submitting work for grading

Typical flow:

1. Commit your changes on a branch.
2. **Push to your fork** and open a **pull request** to the class upstream (or push to the branch your instructor monitors).
3. Open the **Actions** tab on GitHub and open the latest **Exercise tests** workflow run.
4. When the job finishes, download the **`progress-reports`** artifact for the Markdown + JSON the teacher expects.

Keep **TODO comments** and follow any “do not delete TODO” rules in the assignment; replacing `_____` placeholders with real commands is how you complete the work.

## Reference scripts

| Script | Role |
| --- | --- |
| `scripts/setup.sh` | Recreates `lab/files` sample data |
| `scripts/run-all-tests.sh` | Runs all `exercises/**/test.sh` in lesson order |
| `scripts/generate-progress-report.sh` | Rebuilds `reports/progress.{json,md}` from `.last-run.ndjson` |
| `scripts/check.sh` | Lightweight structure/TODO scan (optional helper, not the grader) |

If tests pass locally but fail in CI, compare your environment to **Ubuntu latest** (same as Actions).
