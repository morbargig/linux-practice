#!/bin/bash
set -e

echo "1) Create a script that uses a command without full path..."
# TODO: create a script that calls 'ls' or 'date' without full path
# HINT: Create a script that runs a common command like ls or date
cat > /tmp/test_cron.sh << 'EOF'
#!/bin/bash
_____
EOF
chmod +x /tmp/test_cron.sh

echo ""
echo "2) Run it normally (should work)..."
# TODO: run your script normally
# HINT: Use bash to execute the script
bash /tmp/_____

echo ""
echo "3) Simulate cron environment with minimal PATH..."
# TODO: run script with minimal PATH
# HINT: Set PATH to only /usr/bin and /bin before running
# NOTE: This simulates cron's limited PATH
PATH=_____ bash /tmp/test_cron.sh

echo ""
echo "4) Fix by using full path or setting PATH in script..."
# TODO: modify script to use full path (e.g., /bin/ls) or set PATH at top
# HINT: Set PATH inside the script to include common directories
cat > /tmp/test_cron_fixed.sh << 'EOF'
#!/bin/bash
PATH=_____
ls
EOF
chmod +x /tmp/test_cron_fixed.sh
PATH=/usr/bin:/bin bash /tmp/test_cron_fixed.sh

echo ""
echo "Create cron-fix.md explaining what failed, why, and how you fixed it"
