#!/bin/bash

# Source the timestamp_log function
source "$(dirname "$0")/timestamp_log.sh"

# Log the start of the setup process
timestamp_log "Setting up the app..."

# Create the logs directory and log the event
mkdir -p logs
touch logs/app.log
timestamp_log "Logs directory created and app.log initialized."

# Finalize setup and log it
timestamp_log "App setup complete."
