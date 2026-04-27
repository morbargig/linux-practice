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
user3:150:home
user4:300:work
user5:50:other
EOF
fi

echo "1) Print first field (usernames)"
# TODO: use awk to print first field
# HINT: Use awk with default field separator (space) or specify with -F
awk '{print $_____}' "$DATA_FILE"

echo ""
echo "2) Print second field with colon delimiter"
# TODO: print second field using colon as delimiter
# HINT: Use awk with -F option to set field separator
awk -F: '{print $_____}' "$DATA_FILE"

echo ""
echo "3) Print first and third fields"
# TODO: print multiple fields
# HINT: Use awk to print $1 and $3
awk -F: '{print $_____ " -> " $_____}' "$DATA_FILE"

echo ""
echo "4) Filter rows where second field > 100"
# TODO: filter rows based on numeric comparison
# HINT: Use awk with condition on second field
awk -F: '$_____ > 100' "$DATA_FILE"

echo ""
echo "5) Print rows where third field equals 'work'"
# TODO: filter rows based on string comparison
# HINT: Use awk with string comparison on third field
awk -F: '$_____ == "work"' "$DATA_FILE"

echo ""
echo "6) Calculate sum of second field"
# TODO: sum numeric values in second field
# HINT: Use awk to accumulate sum and print at end
awk -F: '{sum += $_____} END {print "Total: " sum}' "$DATA_FILE"

echo ""
echo "7) Format output with headers"
# TODO: print formatted report with header
# HINT: Use BEGIN to print header, then process data
awk -F: 'BEGIN {print "User:Value:Type"} {print $1 ":" $2 ":" $3}' "$DATA_FILE"

echo ""
echo "Create awk_report.txt with commands and outputs"
