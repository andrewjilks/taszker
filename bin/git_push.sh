#!/bin/bash

# Source the timestamping script correctly
source "$(dirname "$0")/timestamp_log.sh"

# Ensure we're in the project root directory
cd "$(git rev-parse --show-toplevel)"

# Show current git status for debugging purposes and log it
timestamp_log "Current Git Status:"
git status >> logs/app.log

# Log the current branch
timestamp_log "Current branch:"
git branch >> logs/app.log

# Log the status of changes (untracked, modified, etc.)
timestamp_log "Git status (detailed):"
git status --short >> logs/app.log

# Get the commit hash of the latest commit
timestamp_log "Latest commit hash:"
git log -1 --format=%H >> logs/app.log

# Check if there are any changes to commit
if [[ $(git status --porcelain) ]]; then
    timestamp_log "Changes detected. Adding and committing files."

    # Add all changes
    git add . >> logs/app.log

    # Show which files are staged
    timestamp_log "Staged files:"
    git diff --cached --name-only >> logs/app.log

    # Commit changes with a default message
    git commit -m "Auto-commit: updates" >> logs/app.log
else
    timestamp_log "No changes detected. Nothing to commit."
fi

# Log the current date and time of the push attempt
timestamp_log "Push attempt time:"
date >> logs/app.log

# Push to the remote repository and log the output
timestamp_log "Pushing to remote repository..."
git push origin main >> logs/app.log 2>&1

# Check if the push was successful and log the result
if [ $? -eq 0 ]; then
    timestamp_log "Push successful!"
else
    timestamp_log "Push failed."
fi
