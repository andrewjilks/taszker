#!/bin/bash

# Define log file location (adjust as needed)
LOG_FILE="logs/app.log"

# Check if the log file exists
if [ ! -f "$LOG_FILE" ]; then
    echo "Log file not found: $LOG_FILE"
    exit 1
fi

# Ask the user if they want to follow the log
read -p "Do you want to follow the log (tail -f)? (y/n): " follow

if [ "$follow" == "y" ]; then
    # Display the log in real-time using tail and color support
    tail -f "$LOG_FILE" | less -R
else
    # Just display the full log file
    less -R "$LOG_FILE"
fi
