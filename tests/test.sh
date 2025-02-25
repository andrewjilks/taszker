#!/bin/bash

# Source the timestamping script
source ./bin/timestamp_log.sh

# Use the timestamp_log function for logging
timestamp_log "Running tests..."
if ./src/main.sh; then
    timestamp_log "Test passed!"
else
    timestamp_log "Test failed!"
fi
