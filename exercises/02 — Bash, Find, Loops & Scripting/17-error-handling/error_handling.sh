#!/bin/bash
set -e

LAB="../../lab/files"

echo "1) Use || for fallback"
# TODO: try to cat a file, if it fails print "File not found"
cat "$LAB/a.txt" || echo "_____"

echo ""
echo "2) Check if command succeeded"
# TODO: run ls on a file and check exit code
if ls "$LAB/a.txt" >/dev/null 2>&1; then
  echo "File exists"
else
  echo "File not found"
fi

echo ""
echo "3) Validate directory exists"
# TODO: check if directory exists, exit if not
if [ ! -d "$LAB" ]; then
  echo "Error: Directory $LAB not found"
  exit 1
fi
echo "Directory validated ✅"

echo ""
echo "4) Handle command failure gracefully"
# TODO: try to remove a non-existent file, handle error
rm "$LAB/nonexistent.txt" 2>/dev/null || echo "File already removed or doesn't exist"

echo ""
echo "5) Check if file is readable"
# TODO: check if file is readable before processing
file="$LAB/a.txt"
if [ -r "$file" ]; then
  echo "File is readable"
  cat "$file"
else
  echo "File is not readable"
fi

echo "Done ✅"
