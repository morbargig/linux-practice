#!/bin/bash
set -e

LAB="../../lab/files"

echo "1) Find all .conf files"
# TODO: complete the find command
# HINT: find <path> -name "*.conf"
find "$LAB" -name "_____"

echo ""
echo "2) Find files bigger than 5MB"
# TODO: complete size search (use +5M)
find "$LAB" -size _____ -type f
