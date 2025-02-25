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
