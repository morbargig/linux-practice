#!/bin/bash
set -e

LAB="../../lab/files/tmp"

echo "List files older than 7 days (do not delete)"

# TODO: find files older than 7 days
find "$LAB" -type f -mtime _____
