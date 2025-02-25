#!/bin/bash

# Define colors for log levels
RED='\033[0;31m'      # Error
GREEN='\033[0;32m'    # Success
YELLOW='\033[1;33m'   # Warning
BLUE='\033[0;34m'     # Info
RESET='\033[0m'       # Reset color

# Function to log messages with timestamp and color
timestamp_log() {
    # Get the current date and time
    local timestamp=$(date "+[%Y-%m-%d %H:%M:%S]")
    
    # Get log level and message
    local message="$1"
    local level="$2"

    # Set color based on the log level
    case $level in
        "ERROR")
            color=$RED
            ;;
        "SUCCESS")
            color=$GREEN
            ;;
        "WARNING")
            color=$YELLOW
            ;;
        "INFO")
            color=$BLUE
            ;;
        *)
            color=$RESET
            ;;
    esac

    # Print the timestamped, color-coded message
    echo -e "${timestamp} ${color}${message}${RESET}" >> logs/app.log
}
