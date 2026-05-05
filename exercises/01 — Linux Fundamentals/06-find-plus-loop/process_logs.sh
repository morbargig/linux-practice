#!/bin/bash
set -e

LAB="../../lab/files"

echo "Find all .log files and print: filename + number_of_lines"

# TODO: use find + while read
find "$LAB" -name "*.log" | while read -r file
do
  lines=$(wc -l <"$file")
  echo "$(basename "$file") $lines"
done
