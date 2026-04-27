# Exercise 08 — PATH Debugging (which, command -v)

## Goal
Understand how Linux finds commands.

## Tasks
1. Run:
   - `which ls`
   - `command -v ls`
2. Create a script named `hello` in your home directory that prints "hello"
3. Try to run it by typing `hello` (without ./) — observe what happens
4. Fix it by updating PATH temporarily for your shell session.

## Deliverable
Create `path-debug.md`:
- what happened before PATH change
- what you changed
- proof it works after

## Hints
- `./hello` works because it's a relative path.
- PATH controls where Linux searches for commands.

## Docs
- Bash PATH: https://www.gnu.org/software/bash/manual/bash.html#Shell-Variables
- which: https://man7.org/linux/man-pages/man1/which.1.html
