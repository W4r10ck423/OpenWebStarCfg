#!/bin/bash

# Directory to monitor
DOWNLOADS="$HOME/Downloads"

# Find the most recent .jnlp file in the Downloads directory
latest_jnlp=$(find "$DOWNLOADS" -name "*.jnlp" -type f -print0 | xargs -0 ls -t | head -1)

# Check if a file was found
if [ -f "$latest_jnlp" ]; then
    # Remove the com.apple.quarantine attribute
    xattr -d com.apple.quarantine "$latest_jnlp"

    # Open the file
    open "$latest_jnlp"
fi