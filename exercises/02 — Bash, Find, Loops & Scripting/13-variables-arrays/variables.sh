#!/bin/bash
set -e

LAB="../../lab/files"

echo "1) Create and use variables"
# TODO: set name variable to your name
name=_____
echo "Hello, $name!"

echo ""
echo "2) Use command substitution"
# TODO: get current date using $(date)
current_date=$(_____)
echo "Today is: $current_date"

echo ""
echo "3) Create an array of file extensions"
# TODO: create array with: txt conf log
extensions=(_____)
echo "Extensions: ${extensions[@]}"

echo ""
echo "4) Loop through array"
# TODO: loop through extensions array and print each
for ext in _____
do
  echo "Extension: $ext"
done

echo ""
echo "5) Count files by extension"
# TODO: for each extension, count matching files
for ext in "${extensions[@]}"
do
  count=$(find "$LAB" -name "*.$ext" -type f 2>/dev/null | wc -l)
  echo "$ext files: $count"
done
