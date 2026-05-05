#!/bin/bash
set -e

echo "1) Find your user in /etc/passwd"
# TODO: use grep to find your user line
# HINT: Use grep with the $USER variable to search /etc/passwd
awk -F: -v u="$USER" '$1 == u {print}' /etc/passwd

echo ""
echo "2) Find root user in /etc/passwd"
# TODO: use grep to find root user line (starts with root)
# HINT: Use grep with a pattern that matches lines starting with "root"
awk -F: '$1 == "root" {print}' /etc/passwd

echo ""
echo "3) Find a group your user belongs to in /etc/group"
# TODO: use grep to find a group containing your username
# HINT: Search /etc/group for your username using grep
grep -F "$USER" /etc/group || true

echo ""
echo "4) Count total users in /etc/passwd"
# TODO: count lines in /etc/passwd
# HINT: Use a command that counts lines in a file
wc -l /etc/passwd

echo ""
echo "5) Copy relevant lines to report.md and explain the shell field"
