#!/bin/bash
set -e

LAB="../../lab/files"

echo "1) Find all .conf files"
# TODO: complete the find command
# HINT: find <path> -name "*.conf"
find "$LAB" -name "*.conf"

echo ""
echo "2) Find files bigger than 5MB (GNU find uses +5M)"
# TODO: complete size search (use +5M)
find "$LAB" -size +5M -type f
