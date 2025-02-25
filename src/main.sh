#!/bin/bash

# Source the timestamping script
source ./bin/timestamp_log.sh

# Use the timestamp_log function for logging
timestamp_log "Starting the application..."
./bin/setup.sh
timestamp_log "Application started successfully!"
