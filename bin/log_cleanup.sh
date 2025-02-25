#!/bin/bash

# Source the timestamping script
source ./bin/timestamp_log.sh

# Use the timestamp_log function for logging
LOG_DIR="logs"
MAX_SIZE=1000
for file in $LOG_DIR/*.log; do
    line_count=$(wc -l < "$file")
    if [ "$line_count" -gt "$MAX_SIZE" ]; then
        timestamp_log "Archiving $file"
        mv "$file" "$LOG_DIR/archive/"
        touch "$file"
    fi
done
