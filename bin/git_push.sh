#!/bin/bash

# Define color codes for different log types
COLOR_RESET="\e[0m"
COLOR_TIMESTAMP="\e[1;37m" # White
COLOR_INFO="\e[0;36m" # Cyan
COLOR_SUCCESS="\e[0;32m" # Green
COLOR_WARNING="\e[0;33m" # Yellow
COLOR_ERROR="\e[0;31m" # Red
COLOR_HEADER="\e[1;34m" # Blue

# Include timestamp_log.sh for logging
source ./bin/timestamp_log.sh

# Start the process
log_header "Starting the Git push process..."
timestamp_log "Application started for Git operations!" "$COLOR_SUCCESS"

# Check Git status
timestamp_log "Current Git Status:" "$COLOR_INFO"
git status | tail -n 10

# Adding and committing files
timestamp_log "Changes detected. Adding and committing files." "$COLOR_INFO"
git add . && git commit -m "Auto-commit: updates" 2>&1 | tee -a logs/app.log

# Pushing to remote repository
timestamp_log "Pushing to remote repository..." "$COLOR_INFO"
git push 2>&1 | tee -a logs/app.log

# Success message after push
timestamp_log "Push successful!" "$COLOR_SUCCESS"

# Final git status output
timestamp_log "Final Git Status:" "$COLOR_INFO"
git status | tail -n 10

timestamp_log "Git push process complete." "$COLOR_HEADER"
