#!/bin/bash
set -e

echo "1) Start a background process"
# TODO: start sleep command in background
# HINT: Use & at the end of command to run in background
sleep 30 _____

echo ""
echo "2) List background jobs"
# TODO: show current background jobs
# HINT: Use jobs command to see background processes
_____

echo ""
echo "3) Get the process ID of background job"
# TODO: get PID of the background job
# HINT: Use jobs -l or $! to get process ID
BG_PID=$_____
echo "Background PID: $BG_PID"

echo ""
echo "4) Verify process is running"
# TODO: check if process is still running
# HINT: Use ps to check if PID exists
ps -p _____ || echo "Process not found"

echo ""
echo "5) Stop the process gracefully"
# TODO: send TERM signal to stop process
# HINT: Use kill with the PID
kill _____

echo ""
echo "6) Wait a moment and verify termination"
sleep 2
ps -p "$BG_PID" 2>/dev/null && echo "Process still running" || echo "Process terminated"

echo ""
echo "Create process_control.txt with commands and outputs"
