# Exercise 04 – Executable Scripts

## Goal
Debug "Permission denied" errors and fix script execution correctly.

## Tasks
1. Identify why a script cannot be executed
2. Fix script permissions
3. Verify script execution works
4. Understand the executable bit

## Deliverable
Create `executable_fix.txt` with:
- Error messages encountered
- Commands used to fix permissions
- Verification that script now runs

## Hints
- Scripts need execute permission to run directly
- Use `chmod +x script.sh` to make executable
- Check permissions with `ls -l`
- You can always run with `bash script.sh` even without execute bit

## Docs
- File permissions: https://www.gnu.org/software/coreutils/manual/html_node/File-permissions.html
- `chmod` command: https://man7.org/linux/man-pages/man1/chmod.1.html
