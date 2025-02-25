#!/bin/bash

# Function to add timestamp to logs
timestamp_log() {
    local message=$1
    local timestamp
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] $message" >> logs/app.log
}
