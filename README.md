# Linux Practice – find, loops, if/else & bash scripting (Technician Track)

This repository is a hands-on practice project for Linux scripting fundamentals organized into progressive lessons:

**Environment:** Automated grading runs on **Ubuntu** (GitHub Actions). For the smoothest experience, use **Ubuntu natively, WSL2 (Ubuntu), or an Ubuntu VM** so your results match CI. See [docs/student-guide.md](docs/student-guide.md).

**Lesson 01** - Linux Fundamentals: Tools, scripts, find, loops, conditions, debugging  
**Lesson 02** - Bash, Find, Loops & Scripting: File operations, text processing, variables, functions, error handling  
**Lesson 03** - Users, Groups & Environments: User management, groups, sudo, environment variables  
**Lesson 04** - Permissions, Processes & Text Pipelines: File permissions, process management, disk usage, text processing  
**Lesson 05** - Linux Networking for Technicians: IP and interfaces, connectivity, DNS, ports, routing, firewall awareness, troubleshooting

## Lessons Overview (45 exercises total, ~12.5 hours)

### [Lesson 01 – Linux Fundamentals](exercises/01%20%E2%80%94%20Linux%20Fundamentals/) (10 exercises, ~2.5 hours)
Learn the essential building blocks of bash scripting:
- Installing tools, creating scripts, using `find`
- Working with loops and conditions
- Basic debugging and essential commands

**Prerequisites:** Basic Linux command line navigation  
**See:** [exercises/01%20%E2%80%94%20Linux%20Fundamentals/README.md](exercises/01%20%E2%80%94%20Linux%20Fundamentals/README.md)

### [Lesson 02 – Bash, Find, Loops & Scripting](exercises/02%20%E2%80%94%20Bash%2C%20Find%2C%20Loops%20%26%20Scripting/) (9 exercises, ~3 hours)
Build more powerful scripts with advanced concepts:
- File operations, text processing with `grep` and `sed`
- Variables, arrays, and functions
- Piping, redirection, error handling
- Complete backup script project

**Prerequisites:** Completion of Lesson 01  
**See:** [exercises/02%20%E2%80%94%20Bash%2C%20Find%2C%20Loops%20%26%20Scripting/README.md](exercises/02%20%E2%80%94%20Bash%2C%20Find%2C%20Loops%20%26%20Scripting/README.md)

### [Lesson 03 – Users, Groups & Environments](exercises/03%20%E2%80%94%20Users%2C%20Groups%20%26%20Environments/) (10 exercises, ~2.5 hours)
Master Linux user management and environment configuration:
- User and group management (`useradd`, `groupadd`, `usermod`)
- Sudo and permissions (`sudo`, `visudo`)
- Environment variables (`env`, `printenv`, `export`)
- PATH debugging and cron environment

**Prerequisites:** Completion of Lessons 01 and 02  
**See:** [exercises/03%20%E2%80%94%20Users%2C%20Groups%20%26%20Environments/README.md](exercises/03%20%E2%80%94%20Users%2C%20Groups%20%26%20Environments/README.md)

### [Lesson 04 – Permissions, Processes & Text Pipelines](exercises/04%20%E2%80%94%20Permissions%2C%20Processes%20%26%20Text%20Pipelines/) (9 exercises, ~2.5–3 hours)
Essential system administration and text processing skills:
- File permissions and ownership (`chmod`, `chown`, `chgrp`)
- Process inspection and control (`ps`, `kill`, `jobs`)
- Disk usage monitoring (`df`, `du`)
- Text processing pipelines (`cut`, `sort`, `uniq`)
- Basic `awk` scripting for reports

**Prerequisites:** Completion of Lessons 01, 02, and 03  
**See:** [exercises/04%20%E2%80%94%20Permissions%2C%20Processes%20%26%20Text%20Pipelines/README.md](exercises/04%20%E2%80%94%20Permissions%2C%20Processes%20%26%20Text%20Pipelines/README.md)

### [Lesson 05 – Linux Networking for Technicians](exercises/05%20%E2%80%94%20Linux%20Networking%20for%20Technicians/) (7 exercises, ~2 hours)
Practice how a technician verifies network health without unsafe automation:
- IP addresses, interfaces, and default routes (`ip`, `hostname`)
- Connectivity and DNS (`ping`, `nslookup`, `dig`, `/etc/resolv.conf`)
- Listening ports and local HTTP checks (`ss`, `curl`)
- UFW awareness (manual, optional `sudo` only)

**Prerequisites:** Completion of earlier lessons through Lesson 04 (recommended)  
**See:** [exercises/05%20%E2%80%94%20Linux%20Networking%20for%20Technicians/README.md](exercises/05%20%E2%80%94%20Linux%20Networking%20for%20Technicians/README.md)

## Quick Start
1) Clone
```bash
git clone <YOUR_REPO_URL>
cd linux-practice-find-loops
```

2) Setup the lab environment (creates sample files/logs)
```bash
./scripts/setup.sh
```

3) Start exercises
- Go to `exercises/` and choose a lesson
- Read the lesson README to understand prerequisites and learning objectives
- Work through exercises in order within each lesson
- Read individual exercise READMEs and complete TODO parts in `.sh` scripts

4) Check your work
```bash
# Basic structure check (placeholders & layout — not the full grader)
./scripts/check.sh

# Full exercise grading (every exercise/*/test.sh)
# Requires jq (same as CI). Generates reports/progress-report.md + progress.json
./scripts/run-all-tests.sh
```

**CI:** pushes and pull requests run [`.github/workflows/exercise-tests.yml`](.github/workflows/exercise-tests.yml) on Ubuntu (installs `tree` + `jq`, runs `setup.sh`, then the harness). Download the **`progress-reports`** artifact from the Actions run for Markdown/JSON suitable for instructors.

**Guides:** [Student: run tests & submit](docs/student-guide.md) · [Teacher: read reports & add exercises](docs/teacher-guide.md)

## Rules
- Do not delete the TODO comments
- Keep scripts runnable
- Output format matters (checker expects specific lines)

## Folder Guide
- `scripts/` : setup/reset/check tools + exercise harness (`run-all-tests.sh`)
- `docs/`    : student & teacher guides for testing and grading
- `lab/`     : generated practice files (safe sandbox)
- `exercises/`: lessons organized by topic
  - `01 — Linux Fundamentals/`: Basic bash scripting (10 exercises)
  - `02 — Bash, Find, Loops & Scripting/`: Advanced scripting (9 exercises)
  - `03 — Users, Groups & Environments/`: User management & environment (10 exercises)
  - `04 — Permissions, Processes & Text Pipelines/`: Permissions, processes & text processing (9 exercises)
  - `05 — Linux Networking for Technicians/`: Networking checks & troubleshooting (7 exercises)
