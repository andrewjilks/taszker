#!/bin/bash

# Source the timestamp_log function
source "$(dirname "$0")/timestamp_log.sh"

# Define log directory and max size
LOG_DIR="logs"
MAX_SIZE=1000

# Check each log file and archive if necessary
for file in $LOG_DIR/*.log; do
    line_count=$(wc -l < "$file")
    if [ "$line_count" -gt "$MAX_SIZE" ]; then
        timestamp_log "Archiving $file"
        mv "$file" "$LOG_DIR/archive/"
        touch "$file"
        timestamp_log "$file archived and reset."
    fi
done
