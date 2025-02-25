#!/bin/bash

# Function to add timestamp to logs with color-coding
timestamp_log() {
    local message=$1
    local log_level=$2
    local timestamp
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')

    # Set colors based on log level
    case $log_level in
        INFO)
            color="\033[0;32m"  # Green
            ;;
        SUCCESS)
            color="\033[0;34m"  # Blue
            ;;
        ERROR)
            color="\033[0;31m"  # Red
            ;;
        WARNING)
            color="\033[0;33m"  # Yellow
            ;;
        *)
            color="\033[0m"     # Default (no color)
            ;;
    esac

    # Format the log with the timestamp and colored log level
    echo -e "$color[$timestamp] [$log_level] $message\033[0m" >> logs/app.log
}
