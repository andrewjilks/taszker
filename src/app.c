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
