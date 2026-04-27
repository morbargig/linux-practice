#!/bin/bash
set -e

TARGET="../../lab/files/newfile.txt"

if [ _____ ]; then
  echo "File exists"
else
  echo "File not found, creating..."
  # TODO: create the file
  _____ "$TARGET"
fi

echo "Done"
