#!/bin/bash
set -e

MY_LOCAL="local"
# TODO: export MY_EXPORTED variable
# HINT: Use export to make the variable available to child processes
export MY_EXPORTED="_____"

echo "MY_LOCAL=$MY_LOCAL"
echo "MY_EXPORTED=$MY_EXPORTED"

echo ""
echo "3) Testing in subshell..."
# TODO: run a subshell command that accesses variables
# HINT: Use parentheses to create a subshell and access MY_EXPORTED
(echo "Subshell - MY_EXPORTED=$_____")

echo ""
echo "Create notes.txt explaining what you observed and why export matters"
