#!/bin/bash
set -e  # Exit immediately if a command fails

# Correct log file path
LOG_FILE="../logs/app.log"

# Ensure log directory exists
mkdir -p "$(dirname "$LOG_FILE")"

echo "==================== Starting the Git push process... ====================" | tee -a "$LOG_FILE"

# Change to the correct Git directory
cd "$(dirname "$0")/.."

# Ensure all changes are staged
git add -A

# Check if there are any changes to commit
if git diff-index --quiet HEAD --; then
    echo "[INFO] No new changes to commit." | tee -a "$LOG_FILE"
else
    echo "[INFO] Committing changes..." | tee -a "$LOG_FILE"
    git commit -m "Updated project files"
fi

# Push changes
echo "[INFO] Pushing to remote repository..." | tee -a "$LOG_FILE"
git push origin main | tee -a "$LOG_FILE"

echo "[INFO] Git push process complete!" | tee -a "$LOG_FILE"
