#!/bin/bash

# Log file location
LOG_FILE="/home/andrew/taszker/logs/app.log"

# Define color codes for different log types
COLOR_RESET="\e[0m"
COLOR_INFO="\e[0;36m" # Cyan
COLOR_SUCCESS="\e[0;32m" # Green
COLOR_WARNING="\e[0;33m" # Yellow
COLOR_ERROR="\e[0;31m" # Red
COLOR_HEADER="\e[1;34m" # Blue

# Declare counters for different log types
INFO_COUNT=0
SUCCESS_COUNT=0
ERROR_COUNT=0
WARNING_COUNT=0
WARNING_THRESHOLD=5  # Display summary if there are more than 5 warnings

# Function to process logs in real-time
process_logs() {
    tail -f "$LOG_FILE" | while read -r line; do
        # Extract log level based on case-insensitive matching
        if [[ "$line" =~ [Ii]nfo ]]; then
            ((INFO_COUNT++))
            echo -e "${COLOR_INFO}$line${COLOR_RESET}"  # Print in cyan
        elif [[ "$line" =~ [Ss]uccess ]]; then
            ((SUCCESS_COUNT++))
            echo -e "${COLOR_SUCCESS}$line${COLOR_RESET}"  # Print in green
        elif [[ "$line" =~ [Ee]rror ]]; then
            ((ERROR_COUNT++))
            echo -e "${COLOR_ERROR}$line${COLOR_RESET}"  # Print in red
        elif [[ "$line" =~ [Ww]arning ]]; then
            ((WARNING_COUNT++))
            echo -e "${COLOR_WARNING}$line${COLOR_RESET}"  # Print in yellow
        else
            echo "$line"  # Print unclassified lines normally
        fi

        # Print summary only if errors exist or warnings exceed threshold
        if [[ "$ERROR_COUNT" -gt 0 || "$WARNING_COUNT" -ge "$WARNING_THRESHOLD" ]]; then
            print_summary
        fi
    done
}

# Function to print a summary of the log counts
print_summary() {
    echo -e "\n${COLOR_HEADER}Log Summary:${COLOR_RESET}"
    echo -e "${COLOR_INFO}INFO Count: $INFO_COUNT${COLOR_RESET}"
    echo -e "${COLOR_SUCCESS}SUCCESS Count: $SUCCESS_COUNT${COLOR_RESET}"
    echo -e "${COLOR_ERROR}ERROR Count: $ERROR_COUNT${COLOR_RESET}"
    echo -e "${COLOR_WARNING}WARNING Count: $WARNING_COUNT${COLOR_RESET}"
    echo -e "${COLOR_HEADER}==============================${COLOR_RESET}"
}

# Start processing logs in real-time
process_logs
