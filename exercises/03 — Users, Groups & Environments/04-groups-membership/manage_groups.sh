#!/bin/bash
set -e

echo "WARNING: This script requires sudo privileges"
echo "Creating group 'labtech'..."

# TODO: create group named labtech
# HINT: Use the command that creates a new group
sudo groupadd _____

echo ""
echo "Adding techstudent to labtech group..."
# TODO: add techstudent to labtech group
# HINT: Use usermod with options to append (-a) and specify groups (-G)
# NOTE: -a means append, -G specifies groups
sudo usermod _____ labtech techstudent

echo ""
echo "Verifying membership..."
# TODO: check groups for techstudent
# HINT: Use the command that lists groups for a user
groups _____

echo ""
# TODO: check id for techstudent (should show labtech)
# HINT: Use the id command to verify group membership
id _____

echo ""
echo "Create group-proof.txt with commands and outputs"
