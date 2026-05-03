#!/bin/bash
set -e

echo "Printing environment variables for current user:"
echo ""

# TODO: print USER variable
# HINT: Use printenv or echo with $USER to show the current username
printenv USER

echo ""
# TODO: print HOME variable
# HINT: Use printenv to show the home directory path
printenv HOME

echo ""
# TODO: print SHELL variable
# HINT: Use printenv to show the default shell
printenv SHELL

echo ""
# TODO: print PATH variable
# HINT: Use printenv to show the PATH environment variable
printenv PATH

echo ""
echo "5) Count number of directories in PATH"
# TODO: count PATH components (separated by :)
# HINT: Use tr to replace colons with newlines, then count lines
echo "$PATH" | tr ':' '\n' | wc -l

echo ""
echo "Now switch to techstudent and compare:"
echo "  su - techstudent"
echo "  Run this script again"
echo ""
echo "Create env-compare.md with outputs from both users"
