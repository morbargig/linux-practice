#!/bin/bash
set -e

LAB="../../lab/files"

echo "Loop over all .txt files and print: filename + size"

# TODO: complete the loop
for f in "$LAB"/*.txt
do
  # TODO: print name and size in bytes
  # HINT: wc -c <file OR stat -c %s <file
  size=_____
  echo "$(basename "$f") $size"
done
