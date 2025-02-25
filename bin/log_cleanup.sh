#!/bin/bash
LOG_DIR="logs"
MAX_SIZE=1000
for file in $LOG_DIR/*.log; do
    line_count=$(wc -l < "$file")
    if [ "$line_count" -gt "$MAX_SIZE" ]; then
        echo "Archiving $file" >> logs/app.log
        mv "$file" "$LOG_DIR/archive/"
        touch "$file"
    fi
done
