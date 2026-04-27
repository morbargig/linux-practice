#!/bin/bash
set -e

LAB="../../lab/files"

echo "1) Find lines containing 'ERROR' in log files"
# TODO: use grep to find lines with ERROR
_____ "ERROR" "$LAB/logs"/*.log

echo ""
echo "2) Count occurrences of 'INFO'"
# TODO: use grep -c to count INFO lines
count=$(_____ "INFO" "$LAB/logs/app.log")
echo "INFO appears $count times"

echo ""
echo "3) Search case-insensitively for 'warn'"
# TODO: use grep -i for case-insensitive search
_____ "warn" "$LAB/logs"/*.log

echo ""
echo "4) Find lines NOT containing 'INFO'"
# TODO: use grep -v to invert match
_____ "INFO" "$LAB/logs/app.log"
