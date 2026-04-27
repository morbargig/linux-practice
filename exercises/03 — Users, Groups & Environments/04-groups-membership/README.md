# Exercise 04 — Manage Groups (groupadd, usermod -aG)

## Goal
Use groups to manage permissions cleanly.

## Tasks
1. Create a group named `labtech`
2. Add `techstudent` to `labtech`
3. Verify membership with:
   - `groups techstudent`
   - `id techstudent`

## Deliverable
Create `group-proof.txt` with:
- commands used
- outputs of `groups techstudent` and `id techstudent`

## Hints
- Use `usermod -aG` (important: `-a` means append!)
- Group changes may require re-login to apply.

## Docs
- groupadd: https://man7.org/linux/man-pages/man8/groupadd.8.html
- usermod: https://man7.org/linux/man-pages/man8/usermod.8.html
- groups: https://man7.org/linux/man-pages/man1/groups.1.html
