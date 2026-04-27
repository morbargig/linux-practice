#!/bin/bash
set -e

LAB="../../lab/files"

echo "Find all .log files and print: filename + number_of_lines"

# TODO: use find + while read
find "$LAB" -name "_____" | while read -r file
do
  lines=_____
  echo "$(basename "$file") $lines"
done
