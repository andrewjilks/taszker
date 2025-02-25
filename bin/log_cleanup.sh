#!/bin/bash

# Define the log directory and log file
LOG_DIR="logs"
LOG_FILE="logs/app.log"
ARCHIVE_DIR="logs/archive"
MAX_LOG_SIZE=1000  # Max size in lines before archival

# Create the archive directory if it doesn't exist
mkdir -p "$ARCHIVE_DIR"

# Check if the log file exists
if [ ! -f "$LOG_FILE" ]; then
    echo "Log file not found: $LOG_FILE"
    exit 1
fi

# Get the number of lines in the log file
LOG_LINES=$(wc -l < "$LOG_FILE")

# If the number of lines exceeds the max size, archive it
if [ "$LOG_LINES" -gt "$MAX_LOG_SIZE" ]; then
    TIMESTAMP=$(date +'%Y-%m-%d_%H-%M-%S')
    ARCHIVE_FILE="$ARCHIVE_DIR/app_log_$TIMESTAMP.log"

    # Archive the log file
    cp "$LOG_FILE" "$ARCHIVE_FILE"
    echo "Log file archived to $ARCHIVE_FILE"

    # Clear the log file
    echo "Log file cleared." > "$LOG_FILE"
fi
