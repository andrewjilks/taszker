#!/bin/bash

# Define log file location (adjust as needed)
LOG_FILE="logs/app.log"

# Define color codes for different log types
COLOR_RESET="\e[0m"
COLOR_TIMESTAMP="\e[1;37m" # White
COLOR_INFO="\e[0;36m" # Cyan
COLOR_SUCCESS="\e[0;32m" # Green
COLOR_WARNING="\e[0;33m" # Yellow
COLOR_ERROR="\e[0;31m" # Red
COLOR_HEADER="\e[1;34m" # Blue

# Function to log with a timestamp
timestamp_log() {
    local message=$1
    local color=$2
    echo -e "${COLOR_TIMESTAMP}[$(date +'%Y-%m-%d %H:%M:%S')]${COLOR_RESET} ${color}$message${COLOR_RESET}" | tee -a "$LOG_FILE"
}

# Function to log with a header divider
log_header() {
    local message=$1
    echo -e "${COLOR_HEADER}==================== ${message} ====================${COLOR_RESET}" | tee -a "$LOG_FILE"
}

# Start logging
log_header "Starting the application..."
timestamp_log "Application started successfully!" "$COLOR_SUCCESS"

# Add your application-specific logs here (without Git)
timestamp_log "Application logic running..." "$COLOR_INFO"
# Example of additional logging (e.g., monitoring application state)
timestamp_log "Application is still running smoothly!" "$COLOR_SUCCESS"
timestamp_log "Application process completed." "$COLOR_HEADER"
