# Exercise 01 – Understanding File Permissions

## Goal
Learn to read and interpret file permissions using `ls -l`.

## Tasks
1. List files with detailed permissions
2. Identify permission bits (read, write, execute)
3. Understand user, group, and others permissions
4. Identify file types and special permissions

## Deliverable
Create `permissions_analysis.txt` with:
- Output of `ls -l` for several files
- Explanation of what each permission bit means
- Examples of files with different permission sets

## Hints
- Use `ls -l` to see detailed file information
- Permissions are shown as: `rwxrwxrwx` (user, group, others)
- The first character indicates file type (`-` for regular file, `d` for directory)

## Docs
- `ls` command: https://man7.org/linux/man-pages/man1/ls.1.html
- File permissions: https://www.gnu.org/software/coreutils/manual/html_node/File-permissions.html
