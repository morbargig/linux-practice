# Lesson 04 – Permissions, Processes & Text Pipelines

## What You Should Know Before Starting
- Lessons 01–03 completed
- Basic bash scripting confidence
- Understanding of Linux file system
- Familiarity with command line basics

## What You Will Learn
This lesson covers essential Linux system administration and text processing skills:
- File permissions and ownership (`chmod`, `chown`, `chgrp`)
- Understanding permission bits and access control
- Process inspection and control (`ps`, `kill`, `jobs`)
- Disk usage monitoring (`df`, `du`)
- Text processing pipelines (`cut`, `sort`, `uniq`)
- Basic `awk` scripting for reports

## Exercises (9 exercises, ~2.5–3 hours)

1. **[01-file-permissions-basics](01-file-permissions-basics/)** - Understanding file permissions (~20 min)
   - Read permissions with `ls -l`
   - Identify who can do what
   - Understand permission bits
   - Run: `./permissions.sh`

2. **[02-chmod-practice](02-chmod-practice/)** - Modify permissions (~25 min)
   - Use `chmod` with numeric and symbolic modes
   - Fix broken script permissions
   - Practice common permission scenarios
   - Run: `./chmod_practice.sh`

3. **[03-ownership-and-groups](03-ownership-and-groups/)** - Ownership and groups (~25 min)
   - Change file owner and group
   - Understand permission denial despite chmod
   - Use `chown` and `chgrp`
   - **Requires sudo** - Run: `./ownership.sh`

4. **[04-executable-scripts](04-executable-scripts/)** - Executable scripts (~20 min)
   - Debug "Permission denied" errors
   - Fix script execution correctly
   - Understand executable bit
   - Run: `./fix_executable.sh`

5. **[05-process-inspection](05-process-inspection/)** - Process inspection (~20 min)
   - Use `ps` to find running processes
   - Identify user and PID
   - Filter processes by criteria
   - Run: `./process_inspect.sh`

6. **[06-process-control](06-process-control/)** - Process control (~25 min)
   - Start background jobs
   - Stop them safely
   - Verify termination
   - Use `kill` and `jobs`
   - Run: `./process_control.sh`

7. **[07-disk-usage-investigation](07-disk-usage-investigation/)** - Disk usage investigation (~25 min)
   - Find large directories and files
   - Use `df` and `du`
   - Produce a disk usage report
   - Run: `./disk_investigation.sh`

8. **[08-text-pipelines](08-text-pipelines/)** - Text pipelines (~25 min)
   - Extract columns with `cut`
   - Sort data with `sort`
   - Deduplicate with `uniq`
   - Combine tools in pipelines
   - Run: `./text_pipelines.sh`

9. **[09-awk-report](09-awk-report/)** - awk report (~30 min)
   - Build a simple report using `awk`
   - Numeric comparison and formatted output
   - Process structured data
   - Run: `./awk_report.sh`

## Estimated Total Time
~2.5–3 hours for all exercises

## Important Notes
- Exercise 3 requires sudo privileges
- Some exercises involve process management - be careful in production environments
- Text processing exercises use sample data from `lab/files`

## Next Steps
After completing this lesson, you'll have essential system administration and text processing skills needed for Linux technician work. You'll be able to manage permissions, monitor processes, investigate disk usage, and process text data effectively.
