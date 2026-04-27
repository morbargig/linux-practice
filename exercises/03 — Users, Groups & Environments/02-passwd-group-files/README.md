# Exercise 02 — Understand System Users (/etc/passwd, /etc/group)

## Goal
Learn where Linux stores user/group information.

## Tasks
1. View `/etc/passwd` and find:
   - your user line
   - the `root` user line
2. View `/etc/group` and find:
   - a group your user belongs to
3. Answer: What is the "shell" field in `/etc/passwd`?

## Deliverable
Create `report.md` with:
- the lines you found (copy only the relevant lines)
- short explanation of the shell field

## Hints
- Use `grep` to find lines quickly.
- `/etc/passwd` is readable by all users (usually).

## Docs
- passwd file format: https://man7.org/linux/man-pages/man5/passwd.5.html
- group file format: https://man7.org/linux/man-pages/man5/group.5.html
