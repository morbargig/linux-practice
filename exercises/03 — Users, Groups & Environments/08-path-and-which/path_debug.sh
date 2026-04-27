#!/bin/bash
set -e

echo "1) Finding location of 'ls' command..."
# TODO: use which to find ls
# HINT: Use the command that shows the full path of a command
which _____

echo ""
# TODO: use command -v to find ls
# HINT: Use command -v which is a built-in alternative to which
command -v _____

echo ""
echo "2) Creating hello script in home directory..."
# TODO: create a script named hello in $HOME that prints "hello"
# HINT: Create a file named "hello" in your home directory with a shebang and echo command
echo '#!/bin/bash' > "$HOME/_____"
echo 'echo "hello"' >> "$HOME/hello"
chmod +x "$HOME/hello"

echo ""
echo "3) Try running 'hello' (without ./)..."
# TODO: try to run hello command directly
# HINT: Try running the script by name only
# NOTE: This will likely fail - observe the error
_____ 2>&1 || true

echo ""
echo "4) Fix by updating PATH..."
# TODO: add $HOME to PATH temporarily
# HINT: Use export to add $HOME to the beginning of PATH
export PATH="_____:$PATH"

echo ""
echo "5) Try running 'hello' again..."
# TODO: run hello command again
# HINT: Now try running hello by name again
_____

echo ""
echo "Create path-debug.md documenting what happened and how you fixed it"
