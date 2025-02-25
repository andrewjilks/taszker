#!/bin/bash

# Source the timestamp_log function
source "$(dirname "$0")/timestamp_log.sh"

# Log the start of testing
timestamp_log "Running tests..."

# Run the main script and log the result
if ./src/main.sh; then
    timestamp_log "Test passed!"
else
    timestamp_log "Test failed!"
fi
