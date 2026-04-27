#!/bin/bash
set -e

LAB="../../lab/files"

echo "1) List files with detailed permissions"
# TODO: use ls -l to show detailed file information
# HINT: Use ls with the option that shows long format with permissions
ls _____ "$LAB"

echo ""
echo "2) List directories with permissions"
# TODO: list directories with detailed permissions
# HINT: Use ls -ld to show directory permissions (not contents)
ls _____ "$LAB"

echo ""
echo "3) Show permissions for a specific file"
# TODO: show permissions for a.txt
# HINT: Use ls -l with the file path
ls _____ "$LAB/a.txt"

echo ""
echo "4) Count files by permission type"
# TODO: find files that are executable
# HINT: Use find with -perm option to find executable files
find "$LAB" -type f -perm _____ | wc -l

echo ""
echo "Create permissions_analysis.txt with outputs and explanations"
