# Lesson 01 – Bash Fundamentals

## What You Should Know Before Starting
- Basic Linux command line navigation (`cd`, `ls`, `pwd`)
- How to open a terminal
- Basic file system concepts (files, directories)

## What You Will Learn
This lesson covers the essential building blocks of bash scripting:
- Installing and verifying Linux tools
- Creating and running your first bash scripts
- Using the `find` command to locate files
- Working with loops (`for` and `while`)
- Conditional statements (`if/else`)
- Combining commands and concepts
- Basic debugging techniques
- Essential Linux commands (`ls`, `cat`, `wc`, `echo`)

## Exercises (10 exercises, ~2.5 hours)

1. **[01-tools](01-tools/)** - Install and verify common Linux tools (~15 min)
   - Learn to check if tools are installed
   - Install missing packages with `apt`
   - Run: `./tasks.sh`

2. **[02-vscode-bash](02-vscode-bash/)** - Create your first bash script (~10 min)
   - Write your first bash script
   - Understand script structure (`#!/bin/bash`)
   - Run: `./hello.sh`

3. **[03-find](03-find/)** - Practice `find` command (~25 min)
   - Find files by name, type, size, and time
   - Use: `./find_basic.sh` and `./find_advanced.sh`

4. **[04-loops](04-loops/)** - Practice `for` and `while` loops (~30 min)
   - Loop over files and process them
   - Read files line-by-line
   - Use: `./for_loop.sh` and `./while_loop.sh`

5. **[05-if-else](05-if-else/)** - Conditional statements (~20 min)
   - Check file existence
   - Make decisions in scripts
   - Use: `./conditions.sh`

6. **[06-find-plus-loop](06-find-plus-loop/)** - Combine find with loops (~25 min)
   - Process multiple files found by `find`
   - Automate repetitive tasks
   - Use: `./process_logs.sh`

7. **[07-first-script](07-first-script/)** - Write a cleanup script (~20 min)
   - Create a practical script
   - Combine multiple concepts
   - Use: `./cleanup.sh`

8. **[08-debugging](08-debugging/)** - Learn to debug bash scripts (~15 min)
   - Use `set -e` for error handling
   - Add debug output
   - Use: `./debug_me.sh`

9. **[09-challenge](09-challenge/)** - Directory analyzer challenge (~30 min)
   - Apply all learned concepts
   - Build a complete script
   - Use: `./analyzer.sh`

10. **[10-basic-commands](10-basic-commands/)** - Essential commands (~20 min)
    - Master `ls`, `cat`, `wc`, `echo`
    - Format output effectively
    - Use: `./basic_commands.sh`

## Estimated Total Time
~2.5 hours for all exercises

## Next Steps
After completing this lesson, you'll be ready for **Lesson 02 – Intermediate Scripting**, which covers file operations, text processing, variables, functions, and more advanced concepts.
