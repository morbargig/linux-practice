#!/bin/bash
set -e

LAB="../../lab/files"
TEST_FILE="$LAB/test_ownership.txt"

echo "WARNING: This script requires sudo privileges"

# Create a test file
echo "test content" > "$TEST_FILE"

echo "1) Check current ownership"
# TODO: show file ownership
# HINT: Use ls -l to see owner and group
ls -l "$TEST_FILE"

echo ""
echo "2) Check current user and groups"
# TODO: show current user and groups
# HINT: Use id command to see current user and group memberships
_____

echo ""
echo "3) Change file owner (requires sudo)"
# TODO: change owner to root (or another user if available)
# HINT: Use sudo chown to change ownership
# NOTE: This is a demonstration - in practice, change to a valid user
sudo chown _____ "$TEST_FILE" 2>/dev/null || echo "Note: Owner change skipped (requires valid user)"

echo ""
echo "4) Change file group"
# TODO: change group ownership
# HINT: Use sudo chgrp or chown with :group syntax
sudo chgrp _____ "$TEST_FILE" 2>/dev/null || echo "Note: Group change skipped (requires valid group)"

echo ""
echo "5) Verify ownership change"
ls -l "$TEST_FILE"

echo ""
echo "Create ownership_report.txt with commands and explanations"
