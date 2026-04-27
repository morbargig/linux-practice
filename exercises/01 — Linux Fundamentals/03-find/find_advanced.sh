#!/bin/bash
set -e

LAB="../../lab/files"

echo "Advanced find: files modified in last 24 hours"
# TODO: find files modified in last day (-mtime -1)
find "$LAB" -type f -mtime _____
