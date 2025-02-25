#!/bin/bash

# Source timestamp_log script
source ./bin/timestamp_log.sh

# Start the git push process and log
timestamp_log "Starting the application..." "INFO"

# Display the current git status
timestamp_log "Current Git Status:" "INFO"
git status >> logs/app.log 2>&1

# Check if there are changes to commit
if git diff-index --quiet HEAD --; then
    timestamp_log "No changes to commit. Pushing current status." "INFO"
else
    timestamp_log "Changes detected. Adding and committing files." "INFO"
    git add . >> logs/app.log 2>&1
    git commit -m "Auto-commit: updates" >> logs/app.log 2>&1
fi

# Push the changes to the repository
timestamp_log "Pushing to remote repository..." "INFO"
git push origin main >> logs/app.log 2>&1

# Log the push status
timestamp_log "Push successful!" "SUCCESS"

# Display current git status after push
timestamp_log "Current Git Status:" "INFO"
git status >> logs/app.log 2>&1

timestamp_log "Git push process complete." "INFO"
