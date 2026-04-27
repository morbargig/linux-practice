# Exercise 06 – Process Control

## Goal
Learn to start, stop, and manage processes using `jobs`, `kill`, and background execution.

## Tasks
1. Start a process in the background
2. List background jobs
3. Stop a process safely
4. Verify process termination

## Deliverable
Create `process_control.txt` with:
- Commands used to start/stop processes
- Output of jobs command
- Verification that processes were terminated

## Hints
- Use `&` to run a command in background
- Use `jobs` to see background jobs
- Use `kill` with PID to stop a process
- Use `kill -9` only as last resort (force kill)

## Docs
- `jobs` command: https://www.gnu.org/software/bash/manual/bash.html#Job-Control-Basics
- `kill` command: https://man7.org/linux/man-pages/man1/kill.1.html
