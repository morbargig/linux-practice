#!/bin/bash
set -e

LAB="../../lab/files"
TEST_FILE="$LAB/test_chmod.txt"

# Create a test file
echo "test content" > "$TEST_FILE"

echo "1) Check initial permissions"
ls -l "$TEST_FILE"

echo ""
echo "2) Set permissions using numeric mode (read/write for owner, read for others)"
# TODO: use chmod with numeric mode
# HINT: Use chmod with a 3-digit number representing owner/group/others permissions
chmod _____ "$TEST_FILE"
ls -l "$TEST_FILE"

echo ""
echo "3) Add execute permission for owner using symbolic mode"
# TODO: add execute permission for user
# HINT: Use chmod with u+x to add execute for user
chmod _____ "$TEST_FILE"
ls -l "$TEST_FILE"

echo ""
echo "4) Remove write permission for group and others"
# TODO: remove write permission using symbolic mode
# HINT: Use chmod with go-w to remove write for group and others
chmod _____ "$TEST_FILE"
ls -l "$TEST_FILE"

echo ""
echo "5) Set common script permissions (755)"
# TODO: set permissions to 755 (executable script)
# HINT: Use numeric mode with 755
chmod _____ "$TEST_FILE"
ls -l "$TEST_FILE"

echo ""
echo "Create chmod_results.txt with commands and explanations"
