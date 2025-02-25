#!/bin/bash

# Source timestamp_log script to handle logging
source ./bin/timestamp_log.sh

# Log the setup process
timestamp_log "Starting app setup..." "$COLOR_INFO"

# Step 1: Create necessary directories if they don't exist
timestamp_log "Creating directories if needed..." "$COLOR_INFO"
mkdir -p src include config tests logs

# Step 2: Create required files if they don't exist
timestamp_log "Creating required files..." "$COLOR_INFO"

# Create the base C file for the app in src/
if [ ! -f src/app.c ]; then
  cat > src/app.c <<EOF
#include <stdio.h>
#include <stdlib.h>

// Sample structure for tasks
struct task {
    int id;
    char name[100];
    int completed;
};

// Function to display tasks
void display_tasks(struct task tasks[], int size) {
    printf("Task ID | Task Name        | Completed\n");
    printf("----------------------------------------\n");
    for (int i = 0; i < size; i++) {
        printf("%-7d | %-15s | %-9s\n", tasks[i].id, tasks[i].name, tasks[i].completed ? "Yes" : "No");
    }
}

int main() {
    struct task tasks[5] = {
        {1, "Task 1", 0},
        {2, "Task 2", 1},
        {3, "Task 3", 0},
        {4, "Task 4", 1},
        {5, "Task 5", 0}
    };

    display_tasks(tasks, 5);
    return 0;
}
EOF
  timestamp_log "Created src/app.c" "$COLOR_SUCCESS"
fi

# Create the new source and include files
# Only create the new files if they don't already exist
if [ ! -f include/tasks.h ]; then
  touch include/tasks.h
  timestamp_log "Created include/tasks.h" "$COLOR_SUCCESS"
fi

if [ ! -f config/config.h ]; then
  touch config/config.h
  timestamp_log "Created config/config.h" "$COLOR_SUCCESS"
fi

# Create the new test file if it doesn't exist
if [ ! -f tests/test.sh ]; then
  touch tests/test.sh
  timestamp_log "Created tests/test.sh" "$COLOR_SUCCESS"
fi

# Step 3: Set permissions for any new scripts to be executable
timestamp_log "Setting permissions for scripts..." "$COLOR_INFO"
chmod +x bin/*.sh
chmod +x tests/test.sh

# Step 4: Log completion of the setup process
timestamp_log "App setup complete." "$COLOR_SUCCESS"
