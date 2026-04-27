# Exercise 05 — Sudo Basics (controlled root access)

## Goal
Understand the difference between root and sudo.

## Tasks
1. Run a command that requires root (example: list `/root`)
2. Run the same command using sudo
3. Check sudo logs (where supported) or explain where sudo activity is recorded.

## Deliverable
Create `sudo-notes.md`:
- command attempted without sudo + error message
- command with sudo + success output
- short note: "Why sudo is safer than logging in as root?"

## Hints
- Try: `ls /root`
- Logs may be in system journal or auth logs.

## Docs
- sudo manual: https://man7.org/linux/man-pages/man8/sudo.8.html
