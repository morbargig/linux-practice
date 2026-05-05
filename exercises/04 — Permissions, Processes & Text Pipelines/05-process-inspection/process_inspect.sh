#!/bin/bash
set -e

echo "1) List all processes for current user"
echo "Showing ps processes for user $USER"
# TODO: show processes for current user
# HINT: Use ps with option to show processes for a specific user
ps -u "$USER"

echo ""
echo "2) Show all processes with detailed information"
echo "Full ps aux process listing follows"
ps aux

echo ""
echo "3) Find bash processes"
# TODO: find processes containing 'bash'
# HINT: Use ps and grep to filter processes
ps aux | grep bash || true

echo ""
echo "4) Count total processes"
# TODO: count total number of processes
# HINT: Use ps to list processes and wc to count
ps aux | wc -l

echo ""
echo "5) Show process tree"
# TODO: show processes in tree format
# HINT: Use ps with option to show process hierarchy
ps aux --forest 2>/dev/null || ps aux | head -25

echo ""
echo "Create process_list.txt with outputs and explanations"
