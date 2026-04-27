# Lesson 02 – Intermediate Scripting

## What You Should Know Before Starting
- Bash script basics (`#!/bin/bash`, running scripts)
- Using `find` command
- Working with `for` and `while` loops
- Conditional statements (`if/else`)
- Basic Linux commands (`ls`, `cat`, `wc`)

## What You Will Learn
This lesson builds on fundamentals to create more powerful scripts:
- File operations (copy, move, create, delete)
- Text search and processing with `grep`
- Working with variables and arrays
- Creating and using functions
- Piping and redirection (`|`, `>`, `>>`, `<`)
- Advanced `find` patterns
- Error handling techniques
- Text manipulation with `sed`
- Building a complete project combining all concepts

## Exercises (9 exercises, ~3 hours)

1. **[11-file-operations](11-file-operations/)** - File operations (~25 min)
   - Copy, move, create, and delete files
   - Use `cp`, `mv`, `mkdir`, `rm`
   - Run: `./file_ops.sh`

2. **[12-grep-text](12-grep-text/)** - Text search with grep (~25 min)
   - Search for patterns in files
   - Use regular expressions
   - Run: `./grep_search.sh`

3. **[13-variables-arrays](13-variables-arrays/)** - Variables and arrays (~30 min)
   - Store and manipulate data
   - Work with arrays
   - Use command substitution
   - Run: `./variables.sh`

4. **[14-functions](14-functions/)** - Create and use functions (~30 min)
   - Organize code into reusable functions
   - Pass arguments to functions
   - Return values
   - Run: `./functions.sh`

5. **[15-piping-redirection](15-piping-redirection/)** - Piping and redirection (~25 min)
   - Chain commands with pipes (`|`)
   - Redirect output (`>`, `>>`)
   - Redirect input (`<`)
   - Run: `./piping.sh`

6. **[16-advanced-find](16-advanced-find/)** - Advanced find patterns (~30 min)
   - Complex search criteria
   - Execute commands on found files
   - Combine multiple conditions
   - Run: `./advanced_find.sh`

7. **[17-error-handling](17-error-handling/)** - Error handling techniques (~25 min)
   - Check command exit codes
   - Handle errors gracefully
   - Validate inputs
   - Run: `./error_handling.sh`

8. **[18-sed-basics](18-sed-basics/)** - Text manipulation with sed (~30 min)
   - Find and replace text
   - Edit files programmatically
   - Use regular expressions
   - Run: `./sed_basics.sh`

9. **[19-final-project](19-final-project/)** - Complete backup script (~45 min)
   - Combine all learned concepts
   - Build a production-ready script
   - Handle errors and create logs
   - Run: `./backup.sh ../../lab/files`

## Estimated Total Time
~3 hours for all exercises

## Next Steps
After completing this lesson, you'll have mastered intermediate bash scripting. You can proceed to **Lesson 03 – Users & Environment** to learn about Linux user management, permissions, and environment configuration.
