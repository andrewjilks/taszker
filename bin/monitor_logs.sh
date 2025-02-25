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
        # Extract log level based on case-insensitive matching (INFO, SUCCESS, ERROR, WARNING)
        if [[ "$line" =~ [Ii]nfo ]]; then
            # Increase info count
            ((INFO_COUNT++))
            echo -e "${COLOR_INFO}$line${COLOR_RESET}" # Display the line in cyan
        elif [[ "$line" =~ [Ss]uccess ]]; then
            # Increase success count
            ((SUCCESS_COUNT++))
            echo -e "${COLOR_SUCCESS}$line${COLOR_RESET}" # Display the line in green
        elif [[ "$line" =~ [Ee]rror ]]; then
            # Increase error count
            ((ERROR_COUNT++))
            echo -e "${COLOR_ERROR}$line${COLOR_RESET}" # Display the line in red
        elif [[ "$line" =~ [Ww]arning ]]; then
            # Increase warning count
            ((WARNING_COUNT++))
            echo -e "${COLOR_WARNING}$line${COLOR_RESET}" # Display the line in yellow
        fi

        # Print live counters only once after processing the line (without excessive repetition)
        print_live_counters

        # Print summary if there are errors or if warnings exceed threshold
        if [[ "$ERROR_COUNT" -gt 0 || "$WARNING_COUNT" -ge "$WARNING_THRESHOLD" ]]; then
            print_summary
        fi
    done
}

# Function to print live counters (only once per line, not repeatedly)
print_live_counters() {
    # Clear the terminal line before printing (to update without clutter)
    echo -ne "\r${COLOR_HEADER}Live Log Counters: INFO=$INFO_COUNT SUCCESS=$SUCCESS_COUNT ERROR=$ERROR_COUNT WARNING=$WARNING_COUNT${COLOR_RESET}"
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
