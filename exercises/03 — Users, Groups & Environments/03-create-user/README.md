# Exercise 03 — Create a New User (useradd)

## Goal
Create a user correctly with a home directory and shell.

## Tasks
1. Create a new user named `techstudent` with:
   - a home directory
   - bash as the default shell
2. Set a password for `techstudent`
3. Switch to that user and verify:
   - `whoami`
   - `pwd` (should be inside the new home)

## Deliverable
Create `proof.txt` containing:
- the commands you used (not the password!)
- outputs of `whoami` and `pwd` as `techstudent`

## Hints
- You'll need sudo.
- Use `su - techstudent` to load the home environment.

## Docs
- useradd: https://man7.org/linux/man-pages/man8/useradd.8.html
- passwd command: https://man7.org/linux/man-pages/man1/passwd.1.html
- su: https://man7.org/linux/man-pages/man1/su.1.html
