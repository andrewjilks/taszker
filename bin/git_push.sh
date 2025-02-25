#!/bin/bash

# Ensure we're in the project root directory (change to the root directory where the .git folder is located)
cd "$(git rev-parse --show-toplevel)"

# Show current git status for debugging purposes and log it
echo "Current Git Status:" >> logs/app.log
git status >> logs/app.log

# Log the current branch
echo "Current branch:" >> logs/app.log
git branch >> logs/app.log

# Log the status of changes (untracked, modified, etc.)
echo "Git status (detailed):" >> logs/app.log
git status --short >> logs/app.log

# Get the commit hash of the latest commit
echo "Latest commit hash:" >> logs/app.log
git log -1 --format=%H >> logs/app.log

# Check if there are any changes to commit
if [[ $(git status --porcelain) ]]; then
    echo "Changes detected. Adding and committing files." >> logs/app.log

    # Add all changes
    git add . >> logs/app.log

    # Show which files are staged
    echo "Staged files:" >> logs/app.log
    git diff --cached --name-only >> logs/app.log

    # Commit changes with a default message
    git commit -m "Auto-commit: updates" >> logs/app.log
else
    echo "No changes detected. Nothing to commit." >> logs/app.log
fi

# Log the current date and time of the push attempt
echo "Push attempt time:" >> logs/app.log
date >> logs/app.log

# Push to the remote repository and log the output
echo "Pushing to remote repository..." >> logs/app.log
git push origin main >> logs/app.log 2>&1

# Check if the push was successful and log the result
if [ $? -eq 0 ]; then
    echo "Push successful!" >> logs/app.log
else
    echo "Push failed." >> logs/app.log
fi
