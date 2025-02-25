#!/bin/bash

# Source timestamp_log script
source ./bin/timestamp_log.sh

# Log the setup process
timestamp_log "Setting up the app..." "INFO"

# Create necessary directories
mkdir -p logs
touch logs/app.log

# Log completion of setup
timestamp_log "App setup complete." "SUCCESS"
