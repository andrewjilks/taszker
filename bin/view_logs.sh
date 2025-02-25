#!/bin/bash

# Define log file location (adjust as needed)
LOG_FILE="logs/app.log"

# Check if the log file exists
if [ ! -f "$LOG_FILE" ]; then
    echo "Log file not found: $LOG_FILE"
    exit 1
fi

# Use 'less' to display the log with color support
less -R "$LOG_FILE"
