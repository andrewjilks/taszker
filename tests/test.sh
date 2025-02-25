#!/bin/bash
echo "Running tests..."
if ./src/main.sh; then
    echo "Test passed!"
else
    echo "Test failed!"
fi
