#!/bin/bash
set -e

SOURCE_DIR="$1"
BACKUP_BASE="../../lab/backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="$BACKUP_BASE/backup_$TIMESTAMP"
LOG_FILE="$BACKUP_DIR/backup.log"

# Function to log messages
log_message() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# Function to validate source directory
validate_source() {
  if [ -z "$SOURCE_DIR" ]; then
    echo "Usage: $0 <source_directory>"
    exit 1
  fi
  
  if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Directory '$SOURCE_DIR' does not exist"
    exit 1
  fi
}

# Function to create backup directory
create_backup_dir() {
  # TODO: create backup directory using mkdir -p
  _____ -p "$BACKUP_DIR"
  log_message "Backup directory created: $BACKUP_DIR"
}

# Function to copy files
copy_files() {
  log_message "Starting backup from $SOURCE_DIR"
  
  # TODO: copy all files preserving structure
  # HINT: use cp -r to copy recursively
  _____ -r "$SOURCE_DIR"/* "$BACKUP_DIR/" 2>/dev/null || {
    # Alternative: use find if cp fails
    find "$SOURCE_DIR" -type f -exec sh -c 'mkdir -p "$2/$(dirname "$1")" && cp "$1" "$2/$1"' _ {} "$BACKUP_DIR" \;
  }
  
  log_message "Files copied"
}

# Function to create summary
create_summary() {
  # TODO: count files in backup (exclude backup.log)
  file_count=$(find "$BACKUP_DIR" -type f ! -name "backup.log" | _____)
  
  # TODO: calculate total size using du
  total_size=$(_____ -sh "$BACKUP_DIR" | cut -f1)
  
  log_message "=== Backup Summary ==="
  log_message "Source: $SOURCE_DIR"
  log_message "Destination: $BACKUP_DIR"
  log_message "Files backed up: $file_count"
  log_message "Total size: $total_size"
  log_message "Backup completed successfully ✅"
}

# Main execution
main() {
  validate_source
  create_backup_dir
  copy_files
  create_summary
  
  echo ""
  echo "Backup completed! Check $LOG_FILE for details."
}

main
