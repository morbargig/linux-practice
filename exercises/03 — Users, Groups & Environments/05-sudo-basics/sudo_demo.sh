#!/bin/bash
set -e

echo "1) Attempting to list /root without sudo..."
# TODO: try to list /root directory (this should fail)
# HINT: Use the command that lists directory contents
# NOTE: Capture the error message
_____ /root 2>&1 || true

echo ""
echo "2) Listing /root with sudo..."
# TODO: list /root directory using sudo
# HINT: Use sudo before the listing command
sudo _____ /root

echo ""
echo "3) Check sudo logs..."
# TODO: check where sudo activity is logged
# HINT: Use journalctl to check sudo service logs, or check /var/log/auth.log
# NOTE: Location may vary by system
sudo journalctl -u sudo 2>/dev/null || sudo tail -n 5 /var/log/auth.log 2>/dev/null || echo "Log location varies by system"

echo ""
echo "Create sudo-notes.md with error, success output, and explanation"
