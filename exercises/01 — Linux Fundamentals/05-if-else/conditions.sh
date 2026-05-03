#!/bin/bash
set -e

TARGET="../../lab/files/newfile.txt"

if [ -f "$TARGET" ]; then
  echo "File exists"
else
  echo "File not found, creating..."
  # TODO: create the file
  touch "$TARGET"
fi

echo "Done"
