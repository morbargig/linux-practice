# Exercise 07 – Disk Usage Investigation

## Goal
Learn to investigate disk usage using `df` and `du` to find large files and directories.

## Tasks
1. Check overall disk space with `df`
2. Find large directories with `du`
3. Find largest files
4. Produce a disk usage report

## Deliverable
Create `disk_report.txt` with:
- Output of df and du commands
- List of largest directories
- List of largest files
- Summary of disk usage

## Hints
- Use `df -h` for human-readable disk space
- Use `du -h` for human-readable directory sizes
- Use `du -sh *` to see directory sizes
- Use `find` with `-size` to find large files

## Docs
- `df` command: https://man7.org/linux/man-pages/man1/df.1.html
- `du` command: https://man7.org/linux/man-pages/man1/du.1.html
