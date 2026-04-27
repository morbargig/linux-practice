#!/bin/bash
set -e

LAB="../../lab/files"
DATA_FILE="$LAB/logs/app.log"

# Create sample data if needed
if [ ! -f "$DATA_FILE" ]; then
  mkdir -p "$(dirname "$DATA_FILE")"
  cat > "$DATA_FILE" << 'EOF'
user1:100:home
user2:200:work
user3:100:home
user2:200:work
user4:300:other
EOF
fi

echo "1) Extract first column (usernames)"
# TODO: extract first field using cut
# HINT: Use cut with -d for delimiter and -f for field number
cut -d: -f_____ "$DATA_FILE"

echo ""
echo "2) Extract second column (numbers)"
# TODO: extract second field
# HINT: Use cut with field number 2
cut -d: -f_____ "$DATA_FILE"

echo ""
echo "3) Sort data alphabetically"
# TODO: sort the data file
# HINT: Use sort command
sort "$DATA_FILE"

echo ""
echo "4) Sort numerically by second column"
# TODO: sort by numeric value in second column
# HINT: Use sort with -t for delimiter and -n for numeric sort
sort -t: -k_____ -n "$DATA_FILE"

echo ""
echo "5) Remove duplicate lines"
# TODO: remove duplicates (requires sorted input)
# HINT: Use uniq after sorting
sort "$DATA_FILE" | _____

echo ""
echo "6) Count unique values in first column"
# TODO: count unique usernames
# HINT: Extract column, sort, uniq, then count
cut -d: -f1 "$DATA_FILE" | sort | uniq | wc -_____

echo ""
echo "7) Show unique values with counts"
# TODO: show each unique value and how many times it appears
# HINT: Use uniq with -c option (requires sorted input)
sort "$DATA_FILE" | uniq -_____

echo ""
echo "Create pipeline_results.txt with outputs and explanations"
