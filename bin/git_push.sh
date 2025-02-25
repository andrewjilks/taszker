#!/bin/bash

# Ensure we're in the project root directory (change to the root directory where the .git folder is located)
cd "$(git rev-parse --show-toplevel)"

# Show current git status for debugging purposes
echo "Current Git Status:" >> logs/app.log
git status

# Check if there are any changes to commit
if [[ $(git status --porcelain) ]]; then
    echo "Changes detected. Adding and committing files." >> logs/app.log

    # Add all changes
    git add .

    # Show which files are staged
    echo "Staged files:" >> logs/app.log
    git diff --cached --name-only

    # Commit changes with a default message
    git commit -m "Auto-commit: updates"
else
    echo "No changes detected. Nothing to commit." >> logs/app.log
fi

# Push to the remote repository
echo "Pushing to remote repository..." >> logs/app.log
git push origin main

# Check if the push was successful
if [ $? -eq 0 ]; then
    echo "Push successful!" >> logs/app.log
else
    echo "Push failed." >> logs/app.log
fi
