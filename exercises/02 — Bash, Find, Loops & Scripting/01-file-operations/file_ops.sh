#!/bin/bash
set -e

LAB="../../lab/files"
WORK_DIR="$LAB/backup"

echo "(workflow uses mkdir, cp, mv, ls, rm)"

echo "1) Create backup directory"
# TODO: create directory $WORK_DIR
mkdir -p "$WORK_DIR"

echo ""
echo "2) Copy a.txt to backup directory"
# TODO: copy a.txt to backup directory
cp "$LAB/a.txt" "$WORK_DIR/"

echo ""
echo "3) Rename copied file"
# TODO: rename backup/a.txt to backup/a_backup.txt
mv "$WORK_DIR/a.txt" "$WORK_DIR/a_backup.txt"

echo ""
echo "4) List files in backup directory"
ls -l "$WORK_DIR"

echo ""
echo "5) Remove temporary file (if exists)"
# TODO: remove backup/a_backup.txt (use rm)
# HINT: check if file exists first with [ -f ]
if [ -f "$WORK_DIR/a_backup.txt" ]; then
  rm "$WORK_DIR/a_backup.txt"
  echo "File removed"
fi

echo "Done ✅"
