#!/bin/bash
echo "Running tests..." >> logs/app.log
if ./src/main.sh; then
    echo "Test passed!" >> logs/app.log
else
    echo "Test failed!" >> logs/app.log
fi
