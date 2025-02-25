# Taszker

## Project Overview

Taszker is a lightweight shell-based application that focuses on managing log files and running automated tests. It provides an easy-to-use framework for logging app activity, setting up essential directories, and automating the cleanup of log files based on predefined conditions (e.g., log file size). This tool can be further developed with additional features such as better logging formats, advanced configuration options, or even integrations with other services.

## File Structure

The project follows this directory structure:
```
/taszker
├── bin/
│   ├── log_cleanup.sh
│   └── setup.sh
├── config/
│   └── app_config.env
├── logs/
│   └── app.log
├── src/
│   └── main.sh
├── tests/
│   └── test.sh
└── README.md
```

## Running the Application

To start the application, execute the following command:
```bash
./src/main.sh
```

This will start the app, run the setup script, and initialize the log file.

## Log Cleanup

The application automatically handles log cleanup. If the log file exceeds 1000 lines, it will be archived and a new log file will be created.

To manually trigger the log cleanup, run the following command:
```bash
./bin/log_cleanup.sh
```

## Running Tests

The test script ensures the application and setup run without issues. To run the tests, execute:
```bash
./tests/test.sh
```

The test will run the main application and log its status.

## Development and Future Additions

The project can be developed further by adding the following features:
- Improve logging format (e.g., timestamps, log levels)
- Add configuration options for the log cleanup (size threshold, retention period)
- Implement additional automation or integrations

To contribute, feel free to fork the repo, make changes, and create pull requests!

## Setup

To get started with this project, follow these steps:

1. Clone the repository to your local machine:

   ```bash

   git clone https://github.com/andrewjilks/taszker.git

   ```

2. Navigate into the project folder:

   ```bash

   cd taszker

   ```

3. Ensure the required dependencies are installed (if applicable).

   This project does not have external dependencies as of now.

4. Make sure all scripts are executable:

   ```bash

   chmod +x bin/*.sh

   ```


## Git Handling Features

This project includes a convenient script for handling Git operations.

The  script automates the following tasks:

1. Checks for changes in the repository.

2. Stages and commits any changes automatically.

3. Pushes the committed changes to the remote repository on GitHub.


### Usage

To use the Git handling script, follow these steps:

1. Run the  script:

   ```bash

   ./bin/git_push.sh

   ```

2. The script will automatically add, commit, and push any changes to the remote repository.

3. If you have any uncommitted changes, it will stage and commit them before pushing.

4. If there are no changes detected, it will inform you that there is nothing to commit.

