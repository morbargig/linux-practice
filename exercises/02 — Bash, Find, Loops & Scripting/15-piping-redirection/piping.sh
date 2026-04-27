#!/bin/bash
set -e

LAB="../../lab/files"
OUTPUT_DIR="../../lab/output"

mkdir -p "$OUTPUT_DIR"

echo "1) Pipe ls to grep"
# TODO: list files and pipe to grep to find .txt files
ls -1 "$LAB" | _____ "\.txt"

echo ""
echo "2) Redirect output to file"
# TODO: redirect ls output to output/file_list.txt
ls -1 "$LAB" > "$OUTPUT_DIR/file_list.txt"
echo "File list saved"

echo ""
echo "3) Append to file"
# TODO: append date to output/file_list.txt
date >> "$OUTPUT_DIR/file_list.txt"
echo "Date appended"

echo ""
echo "4) Chain pipes: find -> grep -> wc"
# TODO: find all .log files, grep for ERROR, count lines
# HINT: find files, then grep each file, then count
error_count=$(find "$LAB" -name "*.log" -type f -exec grep -h "ERROR" {} \; 2>/dev/null | wc -l)
echo "ERROR lines found: $error_count"

echo ""
echo "5) Redirect stderr"
# TODO: run a command that might fail, redirect stderr to /dev/null
ls "$LAB/nonexistent.txt" 2> /dev/null || echo "File not found (error hidden)"

echo "Done ✅"
