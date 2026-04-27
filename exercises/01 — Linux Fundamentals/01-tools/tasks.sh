#!/bin/bash
set -e

echo "Checking for tree command..."
# TODO: check if tree exists
if command -v _____ >/dev/null 2>&1; then
  echo "tree is installed"
else
  echo "tree not found. Install with: sudo apt install tree"
fi
