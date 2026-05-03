#!/bin/bash
set -e

LAB="../../lab/files"
DATA_FILE="$LAB/tmp/awk_training_colons.txt"

mkdir -p "$(dirname "$DATA_FILE")"
cat >"$DATA_FILE" <<'EOF'
user1:100:home
user2:200:work
user3:150:home
user4:300:work
user5:50:other
EOF

echo "1) Print first field (usernames)"
awk '{print $1}' "$DATA_FILE"

echo ""
echo "2) Print second field with colon delimiter"
awk -F: '{print $2}' "$DATA_FILE"

echo ""
echo "3) Print first and third fields"
awk -F: '{print $1 " -> " $3}' "$DATA_FILE"

echo ""
echo "4) Filter rows where second field > 100"
awk -F: '$2 > 100' "$DATA_FILE"

echo ""
echo "5) Print rows where third field equals 'work'"
awk -F: '$3 == "work"' "$DATA_FILE"

echo ""
echo "6) Calculate sum of second field"
awk -F: '{sum += $2} END {print "Total: " sum}' "$DATA_FILE"

echo ""
echo "7) Format output with headers"
awk -F: 'BEGIN {print "User:Value:Type"} {print $1 ":" $2 ":" $3}' "$DATA_FILE"

echo ""
echo "Create awk_report.txt with commands and outputs"
