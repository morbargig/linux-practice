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
count=$(find "$DIR" -type f -name '*.txt' | wc -l | tr -d '[:space:]')

# TODO: sum total size in bytes
total=0
while IFS= read -r -d '' f; do
  [[ -f "$f" ]] || continue
  sz=$(wc -c <"$f" | tr -d '[:space:]')
  total=$((total + sz))
done < <(find "$DIR" -type f -name '*.txt' -print0)

echo "TXT_COUNT=$count"
echo "TXT_TOTAL_BYTES=$total"
