#!/bin/bash
set -e

LAB="../../lab/files"

echo "1) Create a simple function"
# TODO: create function greet() that prints "Hello from function!"
_____() {
  echo "_____"
}
greet

echo ""
echo "2) Function with parameters"
# TODO: create function print_file() that takes filename and prints it
print_file() {
  local filename=$1
  echo "Contents of $filename:"
  cat "$filename"
}
print_file "$LAB/a.txt"

echo ""
echo "3) Function that returns count"
# TODO: create function count_lines() that takes file and returns line count
count_lines() {
  local file=$1
  # TODO: return line count using wc -l
  wc -l < "$file"
}
lines=$(count_lines "$LAB/logs/app.log")
echo "Log file has $lines lines"

echo ""
echo "4) Function to check file size"
# TODO: create function check_size() that prints file size
check_size() {
  local file=$1
  # TODO: get file size and print it
  # HINT: use wc -c or stat command
  if [[ "$OSTYPE" == "darwin"* ]]; then
    size=$(stat -f%z "$file" 2>/dev/null)
  else
    size=$(stat -c%s "$file" 2>/dev/null)
  fi
  echo "$file size: $size bytes"
}
check_size "$LAB/a.txt"
