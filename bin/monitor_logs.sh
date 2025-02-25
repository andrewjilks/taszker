#!/bin/bash

# Log file location
LOG_FILE="/home/andrew/taszker/logs/app.log"

# Define color codes for different log types
COLOR_RESET="\e[0m"
COLOR_TIMESTAMP="\e[1;37m" # White
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
        # Extract log level based on common patterns (e.g., INFO, SUCCESS, ERROR, WARNING)
        if [[ "$line" =~ INFO ]]; then
            echo -e "${COLOR_INFO}$line${COLOR_RESET}"
            ((INFO_COUNT++))
        elif [[ "$line" =~ SUCCESS ]]; then
            echo -e "${COLOR_SUCCESS}$line${COLOR_RESET}"
            ((SUCCESS_COUNT++))
        elif [[ "$line" =~ ERROR ]]; then
            echo -e "${COLOR_ERROR}$line${COLOR_RESET}"
            ((ERROR_COUNT++))
        elif [[ "$line" =~ WARNING ]]; then
            echo -e "${COLOR_WARNING}$line${COLOR_RESET}"
            ((WARNING_COUNT++))
        else
            echo -e "$line"
        fi

        # Display counters live without overwriting
        print_live_counters

        # Print summary if there are errors or if warnings exceed threshold
        if [[ "$ERROR_COUNT" -gt 0 || "$WARNING_COUNT" -ge "$WARNING_THRESHOLD" ]]; then
            print_summary
        fi
    done
}

# Function to print live counters (using a carriage return to avoid overwriting)
print_live_counters() {
    echo -e "\r${COLOR_HEADER}Live Log Counters: INFO=$INFO_COUNT SUCCESS=$SUCCESS_COUNT ERROR=$ERROR_COUNT WARNING=$WARNING_COUNT${COLOR_RESET}"
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
