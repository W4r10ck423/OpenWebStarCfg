#!/bin/bash

# Directory to monitor
DOWNLOADS="$HOME/Downloads"


# Current time in seconds since the epoch
current_time=$(date +%s)

# Time interval in seconds (2 minutes)
time_interval=120

# Find the most recent .jnlp file in the Downloads directory within the last 2 minutes
latest_jnlp=$(find "$DOWNLOADS" -name "*.jnlp" -type f -mmin -2 -print0 | xargs -0 ls -t | head -1)

# Check if a file was found
if [ -n "$latest_jnlp" ]; then
    # Get the file's creation time in seconds since the epoch
    file_creation_time=$(stat -f "%B" "$latest_jnlp")

    # Calculate the time difference
    time_difference=$((current_time - file_creation_time))

    # Check if the file was created within the last 2 minutes
    if [ $time_difference -le $time_interval ]; then
        # Remove the com.apple.quarantine attribute
        xattr -d com.apple.quarantine "$latest_jnlp"

        # Open the file
        open "$latest_jnlp"
    fi
fi

