#!/bin/bash

# Ensure we're in the project root directory (change to the root directory where the .git folder is located)
cd "$(git rev-parse --show-toplevel)"

# Show current git status for debugging purposes
echo "Current Git Status:"
git status

# Check if there are any changes to commit
if [[ $(git status --porcelain) ]]; then
    echo "Changes detected. Adding and committing files."

    # Add all changes
    git add .

    # Show which files are staged
    echo "Staged files:"
    git diff --cached --name-only

    # Commit changes with a default message
    git commit -m "Auto-commit: updates"
else
    echo "No changes detected. Nothing to commit."
fi

# Push to the remote repository
echo "Pushing to remote repository..."
git push origin main

# Check if the push was successful
if [ $? -eq 0 ]; then
    echo "Push successful!"
else
    echo "Push failed."
fi
