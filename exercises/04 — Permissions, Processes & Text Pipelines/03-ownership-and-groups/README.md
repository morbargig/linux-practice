# Exercise 03 – Ownership and Groups

## Goal
Learn to change file ownership and understand how ownership affects permissions.

## Tasks
1. Check current file ownership
2. Change file owner using `chown`
3. Change file group using `chgrp`
4. Understand permission denial despite correct permissions

## Deliverable
Create `ownership_report.txt` with:
- Commands used
- Before and after ownership changes
- Explanation of why ownership matters

## Hints
- Use `chown user:group file` to change both owner and group
- Use `chgrp group file` to change only the group
- Ownership affects who can change permissions
- **Requires sudo** for changing ownership

## Docs
- `chown` command: https://man7.org/linux/man-pages/man1/chown.1.html
- `chgrp` command: https://man7.org/linux/man-pages/man1/chgrp.1.html
