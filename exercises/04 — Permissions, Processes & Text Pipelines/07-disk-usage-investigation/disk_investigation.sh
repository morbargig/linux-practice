#!/bin/bash
set -e

LAB="../../lab/files"

echo "1) Check overall disk space"
# TODO: show disk space usage
# HINT: Use df with option for human-readable format
df _____

echo ""
echo "2) Check disk space for current filesystem"
# TODO: show disk space for current directory's filesystem
# HINT: Use df -h with current directory
df _____ .

echo ""
echo "3) Show directory sizes in lab/files"
# TODO: show sizes of directories
# HINT: Use du with options for human-readable and summary
du _____ "$LAB"/* 2>/dev/null | head -5

echo ""
echo "4) Find largest directories"
# TODO: find and sort directories by size
# HINT: Use du to get sizes, sort to order them, head to show top
du -h "$LAB" 2>/dev/null | sort -_____ | tail -5

echo ""
echo "5) Find large files (over 1KB)"
# TODO: find files larger than 1KB
# HINT: Use find with -size option
find "$LAB" -type f -size +_____ -exec ls -lh {} \; 2>/dev/null | head -5

echo ""
echo "6) Calculate total size of lab/files"
# TODO: get total size of directory
# HINT: Use du with -s for summary and -h for human-readable
du _____ "$LAB"

echo ""
echo "Create disk_report.txt with outputs and summary"
