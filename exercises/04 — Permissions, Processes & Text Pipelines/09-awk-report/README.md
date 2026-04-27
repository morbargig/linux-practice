# Exercise 09 – awk Report

## Goal
Learn basic `awk` scripting to process structured data and generate reports.

## Tasks
1. Print specific fields from structured data
2. Perform numeric comparisons
3. Format output
4. Generate a simple report

## Deliverable
Create `awk_report.txt` with:
- awk commands used
- Output of each command
- Explanation of awk syntax

## Hints
- `awk '{print $1}'` prints first field
- `awk -F: '{print $2}'` uses colon as field separator
- `awk '$2 > 100'` filters rows where second field > 100
- Combine conditions: `awk '$2 > 100 && $3 == "work"'`

## Docs
- `awk` command: https://man7.org/linux/man-pages/man1/awk.1.html
- GNU awk manual: https://www.gnu.org/software/gawk/manual/
