#!/bin/bash

# Ensure we're in the project root directory
cd "$(git rev-parse --show-toplevel)"

# Source the timestamp_log function
source "$(dirname "$0")/timestamp_log.sh"  # This line ensures the timestamp_log function is sourced correctly

# Log the start of the git push process
timestamp_log "Starting Git Push..." "INFO"

# Show current git status for debugging purposes and log it
timestamp_log "Current Git Status:" "INFO"
git status >> logs/app.log

# Log the current branch
timestamp_log "Current branch:" "INFO"
git branch >> logs/app.log

# Log the status of changes (untracked, modified, etc.)
timestamp_log "Git status (detailed):" "INFO"
git status --short >> logs/app.log

# Get the commit hash of the latest commit
timestamp_log "Latest commit hash:" "INFO"
git log -1 --format=%H >> logs/app.log

# Check if there are any changes to commit
if [[ $(git status --porcelain) ]]; then
    timestamp_log "Changes detected. Adding and committing files." "WARNING"

    # Add all changes
    git add . >> logs/app.log

    # Show which files are staged
    timestamp_log "Staged files:" "INFO"
    git diff --cached --name-only >> logs/app.log

    # Commit changes with a default message
    git commit -m "Auto-commit: updates" >> logs/app.log
else
    timestamp_log "No changes detected. Nothing to commit." "SUCCESS"
fi

# Log the current date and time of the push attempt
timestamp_log "Push attempt time:" "INFO"
date >> logs/app.log

# Push to the remote repository and log the output
timestamp_log "Pushing to remote repository..." "INFO"
git push origin main >> logs/app.log 2>&1

# Check if the push was successful and log the result
if [ $? -eq 0 ]; then
    timestamp_log "Push successful!" "SUCCESS"
else
    timestamp_log "Push failed." "ERROR"
fi
