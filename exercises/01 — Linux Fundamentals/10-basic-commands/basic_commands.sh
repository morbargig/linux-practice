#!/bin/bash
set -e

LAB="../../lab/files"

echo "1) List files with details"
# TODO: use ls -l to list files with details
_____ "$LAB"

echo ""
echo "2) Display contents of a.txt"
# TODO: use cat to display file contents
_____ "$LAB/a.txt"

echo ""
echo "3) Count lines in app.log"
# TODO: use wc -l to count lines
lines=$(_____ "$LAB/logs/app.log")
echo "Lines: $lines"

echo ""
echo "4) Print formatted message"
# TODO: use echo to print: "File count: X" where X is the number of .txt files
count=$(ls "$LAB"/*.txt 2>/dev/null | wc -l)
echo "_____"
