#!/bin/bash
set -e

echo "1) List all processes for current user"
# TODO: show processes for current user
# HINT: Use ps with option to show processes for a specific user
ps -u _____

echo ""
echo "2) Show all processes with detailed information"
# TODO: show all processes with full details
# HINT: Use ps with options that show all processes and full format
ps _____

echo ""
echo "3) Find bash processes"
# TODO: find processes containing 'bash'
# HINT: Use ps and grep to filter processes
ps aux | grep _____

echo ""
echo "4) Count total processes"
# TODO: count total number of processes
# HINT: Use ps to list processes and wc to count
ps aux | wc -_____

echo ""
echo "5) Show process tree"
# TODO: show processes in tree format
# HINT: Use ps with option to show process hierarchy
ps _____ 2>/dev/null || echo "Tree format not available on this system"

echo ""
echo "Create process_list.txt with outputs and explanations"
