#!/bin/bash
set -e

LAB="../../lab/files"
SCRIPT="$LAB/broken_script.sh"

# Create a script without execute permission
cat > "$SCRIPT" << 'EOF'
#!/bin/bash
echo "This script works!"
EOF

echo "1) Check script permissions"
# TODO: show current permissions
# HINT: Use ls -l to see permissions
ls -l "$SCRIPT"

echo ""
echo "2) Try to run script (will fail)"
# TODO: try to execute the script directly
# HINT: Try running ./broken_script.sh
./"$SCRIPT" 2>&1 || echo "Error captured (expected)"

echo ""
echo "3) Check if we can run it with bash"
# TODO: run script using bash explicitly
# HINT: Use bash to run the script
_____ "$SCRIPT"

echo ""
echo "4) Fix permissions to make it executable"
# TODO: add execute permission
# HINT: Use chmod to add execute permission
chmod _____ "$SCRIPT"

echo ""
echo "5) Verify permissions changed"
ls -l "$SCRIPT"

echo ""
echo "6) Run script directly (should work now)"
# TODO: run the script directly
# HINT: Now try running ./broken_script.sh again
./"$SCRIPT"

echo ""
echo "Create executable_fix.txt with error messages and fix steps"
