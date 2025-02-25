#!/bin/bash

# Source the timestamping script
source ./bin/timestamp_log.sh

# Use the timestamp_log function for logging
timestamp_log "Setting up the app..."
mkdir -p logs
touch logs/app.log
timestamp_log "App setup complete."
