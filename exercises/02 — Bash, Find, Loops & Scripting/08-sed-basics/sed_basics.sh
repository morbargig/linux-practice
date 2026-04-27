#!/bin/bash
set -e

LAB="../../lab/files"
OUTPUT_DIR="../../lab/output"

mkdir -p "$OUTPUT_DIR"

echo "1) Replace text in output"
# TODO: echo a string and use sed to replace 'alpha' with 'ALPHA'
echo "alpha beta gamma" | sed 's/_____/_____/'

echo ""
echo "2) Replace all occurrences"
# TODO: replace all 'INFO' with 'LOG' in app.log output
cat "$LAB/logs/app.log" | sed 's/_____/_____/g'

echo ""
echo "3) Delete lines containing pattern"
# TODO: print app.log but delete lines with 'WARN'
cat "$LAB/logs/app.log" | sed '/_____/d'

echo ""
echo "4) Print specific line numbers"
# TODO: print only line 2 from app.log
sed -n '_____p' "$LAB/logs/app.log"

echo ""
echo "5) Replace and save to new file"
# TODO: replace 'INFO' with 'LOG' and save to output/modified.log
sed 's/INFO/LOG/g' "$LAB/logs/app.log" > "$OUTPUT_DIR/modified.log"
echo "Modified log saved"

echo ""
echo "6) Use sed with find"
# TODO: find all .log files and replace 'INFO' with 'LOG' in output
find "$LAB" -name "*.log" -type f -exec sed 's/INFO/LOG/g' {} \; > "$OUTPUT_DIR/all_modified.log"
echo "All logs processed"
