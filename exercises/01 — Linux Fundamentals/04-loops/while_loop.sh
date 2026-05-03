#!/bin/bash
set -e

FILE="../../lab/files/logs/app.log"

echo "Read file line-by-line and print line number + content"

# TODO: implement counter
n=1

while read -r line
do
  echo "$n $line"
  n=$((n+1))
done < "$FILE"
