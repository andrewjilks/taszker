#!/bin/bash

# Source timestamp_log script
source ./bin/timestamp_log.sh

# Running tests and logging the process
timestamp_log "Running tests..." "INFO"

# If the test passes
if ./src/main.sh; then
    timestamp_log "Test passed!" "SUCCESS"
else
    timestamp_log "Test failed!" "ERROR"
fi
