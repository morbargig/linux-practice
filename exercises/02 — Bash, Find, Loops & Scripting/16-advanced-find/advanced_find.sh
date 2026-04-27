#!/bin/bash
set -e

LAB="../../lab/files"

echo "1) Find empty files"
# TODO: find empty files using -empty
find "$LAB" -type f -empty

echo ""
echo "2) Find files and print their sizes"
# TODO: use find with -exec to print file sizes
find "$LAB" -type f -name "*.txt" -exec ls -lh {} \;

echo ""
echo "3) Find files modified in last 2 days"
# TODO: use -mtime -2 for files modified in last 2 days
find "$LAB" -type f -mtime _____

echo ""
echo "4) Find files larger than 1MB"
# TODO: use -size +1M
find "$LAB" -type f -size _____

echo ""
echo "5) Find and count .conf files"
# TODO: find .conf files and count them
conf_count=$(find "$LAB" -name "*.conf" -type f | wc -l)
echo "Found $conf_count .conf files"

echo ""
echo "6) Find files and execute command"
# TODO: find .log files and print first line of each
find "$LAB" -name "*.log" -type f -exec head -n 1 {} \;
