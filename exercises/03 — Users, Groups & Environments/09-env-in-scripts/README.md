# Exercise 09 — Environment Variables in Scripts (export)

## Goal
Learn the difference between local variables and exported environment variables.

## Tasks
1. Create a script `showenv.sh` that prints:
   - a normal variable
   - an exported variable
2. Run it and observe differences.

## Starter
Create `showenv.sh` and fill in missing parts:
```bash
#!/bin/bash

MY_LOCAL="local"
# TODO: export MY_EXPORTED

echo "MY_LOCAL=$MY_LOCAL"
echo "MY_EXPORTED=$MY_EXPORTED"
```

## Deliverable
Create `notes.txt`:
- what you observed
- why export matters

## Hints
- "export" makes the variable available to child processes.

## Docs
- Bash variables/export: https://www.gnu.org/software/bash/manual/bash.html#Shell-Parameters
