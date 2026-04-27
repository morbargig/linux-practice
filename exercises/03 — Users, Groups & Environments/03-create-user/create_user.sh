#!/bin/bash
set -e

echo "WARNING: This script requires sudo privileges"
echo "Creating user 'techstudent'..."

# TODO: create user with home directory and bash shell
# HINT: Use useradd with options to create home directory (-m) and set shell (-s)
# NOTE: -m creates home directory, -s sets shell
sudo useradd _____ -s /bin/bash techstudent

echo ""
echo "Setting password for techstudent..."
# TODO: set password (will prompt for input)
# HINT: Use the command that changes user passwords
sudo passwd _____

echo ""
echo "Verifying user was created..."
# TODO: check if user exists in /etc/passwd
# HINT: Use grep to search for "techstudent" in /etc/passwd
grep _____ /etc/passwd

echo ""
echo "Switching to techstudent user..."
echo "Run these commands manually:"
echo "  su - techstudent"
echo "  whoami"
echo "  pwd"
echo ""
echo "Then create proof.txt with commands and outputs"
