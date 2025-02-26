#include <gtk/gtk.h>
#include <json-c/json.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define JSON_FILE "/home/andrew/taszker/tasks.json"

json_object *load_tasks();
void save_tasks(json_object *json);
void add_task(GtkWidget *widget, gpointer data);
void open_add_task_window(GtkWidget *widget, gpointer data);
void load_task_display(GtkWidget *widget, gpointer data);
void start_ui(GtkApplication *app, gpointer user_data);

// Load tasks from JSON
json_object *load_tasks() {
    FILE *fp = fopen(JSON_FILE, "r");
    if (!fp) {
        perror("Failed to open JSON file");
        return json_object_new_object();
    }

    fseek(fp, 0, SEEK_END);
    long file_size = ftell(fp);
    rewind(fp);

    if (file_size == 0) {
        fclose(fp);
        printf("JSON file is empty.\n");
        return json_object_new_object();
    }

    char *buffer = malloc(file_size + 1);
    if (!buffer) {
        fclose(fp);
        perror("Memory allocation failed");
        return json_object_new_object();
    }

    fread(buffer, 1, file_size, fp);
    fclose(fp);
    buffer[file_size] = '\0';

    printf("JSON data read:\n%s\n", buffer);

    json_object *parsed_json = json_tokener_parse(buffer);
    free(buffer);

    if (!parsed_json) {
        fprintf(stderr, "Error parsing JSON file\n");
        return json_object_new_object();
    }

    printf("JSON successfully loaded.\n");
    return parsed_json;
}

// Save JSON file
void save_tasks(json_object *json) {
    FILE *fp = fopen(JSON_FILE, "w");
    if (!fp) {
        perror("Failed to write JSON file");
        return;
    }
    fprintf(fp, "%s", json_object_to_json_string(json));
    fclose(fp);
}

// Add task to JSON
void add_task(GtkWidget *widget, gpointer data) {
    json_object *tasks_json = load_tasks();
    json_object *tasks_array;

    if (!json_object_object_get_ex(tasks_json, "tasks", &tasks_array)) {
        tasks_array = json_object_new_array();
        json_object_object_add(tasks_json, "tasks", tasks_array);
    }

    GtkWidget **entries = (GtkWidget **)data;

    // Ensure widgets are editable before accessing text
    const char *name = GTK_IS_EDITABLE(entries[0]) ? gtk_editable_get_text(GTK_EDITABLE(entries[0])) : "";
    const char *due_date = GTK_IS_EDITABLE(entries[1]) ? gtk_editable_get_text(GTK_EDITABLE(entries[1])) : "";
    const char *status = GTK_IS_EDITABLE(entries[2]) ? gtk_editable_get_text(GTK_EDITABLE(entries[2])) : "";
    const char *notes = GTK_IS_EDITABLE(entries[3]) ? gtk_editable_get_text(GTK_EDITABLE(entries[3])) : "";

    json_object *new_task = json_object_new_object();
    json_object_object_add(new_task, "name", json_object_new_string(name));
    json_object_object_add(new_task, "due_date", json_object_new_string(due_date));
    json_object_object_add(new_task, "status", json_object_new_string(status));
    json_object_object_add(new_task, "notes", json_object_new_string(notes));

    json_object_array_add(tasks_array, new_task);
    save_tasks(tasks_json);
    json_object_put(tasks_json);

    // Close the add task window
    GtkWidget *window = gtk_widget_get_ancestor(widget, GTK_TYPE_WINDOW);
    if (GTK_IS_WINDOW(window)) {
        gtk_window_destroy(GTK_WINDOW(window));
    }
}

// Open "Add Task" window
void open_add_task_window(GtkWidget *widget, gpointer data) {
    GtkWidget *window = gtk_application_window_new(GTK_APPLICATION(data));
    gtk_window_set_title(GTK_WINDOW(window), "Add Task");
    gtk_window_set_default_size(GTK_WINDOW(window), 300, 300);

    GtkWidget *box = gtk_box_new(GTK_ORIENTATION_VERTICAL, 5);
    gtk_window_set_child(GTK_WINDOW(window), box);

    GtkWidget *entry_name = gtk_entry_new();
    GtkWidget *entry_due = gtk_entry_new();
    GtkWidget *entry_status = gtk_entry_new();
    GtkWidget *entry_notes = gtk_entry_new();

    GtkWidget *label1 = gtk_label_new("Task Name:");
    GtkWidget *label2 = gtk_label_new("Due Date (YYYY-MM-DD):");
    GtkWidget *label3 = gtk_label_new("Status:");
    GtkWidget *label4 = gtk_label_new("Notes:");

    GtkWidget *button_submit = gtk_button_new_with_label("Add Task");

    gtk_box_append(GTK_BOX(box), label1);
    gtk_box_append(GTK_BOX(box), entry_name);
    gtk_box_append(GTK_BOX(box), label2);
    gtk_box_append(GTK_BOX(box), entry_due);
    gtk_box_append(GTK_BOX(box), label3);
    gtk_box_append(GTK_BOX(box), entry_status);
    gtk_box_append(GTK_BOX(box), label4);
    gtk_box_append(GTK_BOX(box), entry_notes);
    gtk_box_append(GTK_BOX(box), button_submit);

    // Allocate entries array properly
    GtkWidget **entries = g_new(GtkWidget *, 4);
    entries[0] = entry_name;
    entries[1] = entry_due;
    entries[2] = entry_status;
    entries[3] = entry_notes;

    g_signal_connect(button_submit, "clicked", G_CALLBACK(add_task), entries);
    gtk_window_present(GTK_WINDOW(window));
}

// Load and display tasks
void load_task_display(GtkWidget *widget, gpointer data) {
    json_object *tasks_json = load_tasks();
    json_object *tasks_array;

    if (!json_object_object_get_ex(tasks_json, "tasks", &tasks_array)) {
        gtk_label_set_text(GTK_LABEL(data), "No tasks found.");
        json_object_put(tasks_json);
        return;
    }

    int array_length = json_object_array_length(tasks_array);
    GString *task_text = g_string_new("");

    for (int i = 0; i < array_length; i++) {
        json_object *task = json_object_array_get_idx(tasks_array, i);
        const char *name = json_object_get_string(json_object_object_get(task, "name"));
        const char *due = json_object_get_string(json_object_object_get(task, "due_date"));
        const char *status = json_object_get_string(json_object_object_get(task, "status"));
        const char *notes = json_object_get_string(json_object_object_get(task, "notes"));

        g_string_append_printf(task_text, "Task: %s\nDue: %s\nStatus: %s\nNotes: %s\n\n", name, due, status, notes);
    }

    gtk_label_set_text(GTK_LABEL(data), task_text->str);
    g_string_free(task_text, TRUE);
    json_object_put(tasks_json);
}

// Main UI
void start_ui(GtkApplication *app, gpointer user_data) {
    GtkWidget *window = gtk_application_window_new(app);
    gtk_window_set_title(GTK_WINDOW(window), "Taszker");
    gtk_window_set_default_size(GTK_WINDOW(window), 400, 400);

    GtkWidget *box = gtk_box_new(GTK_ORIENTATION_VERTICAL, 5);
    gtk_window_set_child(GTK_WINDOW(window), box);

    GtkWidget *task_label = gtk_label_new("Loading tasks...");
    gtk_box_append(GTK_BOX(box), task_label);

    GtkWidget *button_refresh = gtk_button_new_with_label("Refresh Tasks");
    gtk_box_append(GTK_BOX(box), button_refresh);
    g_signal_connect(button_refresh, "clicked", G_CALLBACK(load_task_display), task_label);

    GtkWidget *button_add = gtk_button_new_with_label("Add Task");
    gtk_box_append(GTK_BOX(box), button_add);
    g_signal_connect(button_add, "clicked", G_CALLBACK(open_add_task_window), app);

    load_task_display(NULL, task_label);
    gtk_window_present(GTK_WINDOW(window));
}

// Main
int main(int argc, char *argv[]) {
    GtkApplication *app = gtk_application_new("com.taszker.app", G_APPLICATION_DEFAULT_FLAGS);
    g_signal_connect(app, "activate", G_CALLBACK(start_ui), NULL);

    int status = g_application_run(G_APPLICATION(app), argc, argv);
    g_object_unref(app);

    return status;
}
