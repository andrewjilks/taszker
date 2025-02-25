#!/bin/bash

# Source timestamp_log script
source ./bin/timestamp_log.sh

# Clean up old logs and archive them
timestamp_log "Cleaning up old log files..." "INFO"
for file in logs/*.log; do
    if [ -f "$file" ]; then
        timestamp_log "Archiving $file" "INFO"
        mv "$file" "logs/archive/$(basename $file)_$(date +%Y%m%d_%H%M%S).log"
    fi
done

# Log cleanup completion
timestamp_log "Log cleanup complete." "SUCCESS"
