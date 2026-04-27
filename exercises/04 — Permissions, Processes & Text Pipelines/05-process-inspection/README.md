# Exercise 05 – Process Inspection

## Goal
Learn to inspect running processes using `ps` and identify process details.

## Tasks
1. List all processes for current user
2. Find specific processes by name
3. Identify process IDs (PIDs)
4. Show process details (user, command, PID)

## Deliverable
Create `process_list.txt` with:
- Output of various ps commands
- List of your running processes
- Explanation of PID and process information

## Hints
- Use `ps aux` to see all processes
- Use `ps -u $USER` to see your processes
- Use `ps aux | grep` to find specific processes
- PID is the process identifier number

## Docs
- `ps` command: https://man7.org/linux/man-pages/man1/ps.1.html
