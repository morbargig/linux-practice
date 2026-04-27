#!/bin/bash
set -e

DIR="$1"

if [ -z "$DIR" ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

if [ ! -d "$DIR" ]; then
  echo "Directory not found: $DIR"
  exit 1
fi

# TODO: count txt files
count=_____

# TODO: sum total size in bytes
total=_____

echo "TXT_COUNT=$count"
echo "TXT_TOTAL_BYTES=$total"
