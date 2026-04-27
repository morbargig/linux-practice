# Exercise 10 — Cron Environment Gap (common technician issue)

## Goal
Understand why scripts work in terminal but fail in cron.

## Tasks
1. Create a script that depends on PATH (example: calls a command without full path)
2. Run it in terminal (works)
3. Simulate "cron-like" environment by running with a minimal PATH
4. Fix it by using full paths OR defining PATH inside the script

## Deliverable
Create `cron-fix.md`:
- what failed
- why it failed (environment difference)
- how you fixed it

## Hints
- Cron runs with a limited environment.
- Production fix: explicit paths + safe environment setup.

## Docs
- crontab: https://man7.org/linux/man-pages/man5/crontab.5.html
- environment and cron notes: https://man7.org/linux/man-pages/man8/cron.8.html
