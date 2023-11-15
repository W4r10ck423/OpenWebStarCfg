#!/bin/bash

# Get current username
username=$(whoami)

# Define the watch path
watchpath="/Users/$username/Downloads"

# Output file name
output_file="output.plist"

# Create the XML content and write to the output file
cat <<EOT > $output_file
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.apololab.handlejnlp</string>

    <key>ProgramArguments</key>
    <array>
        <string>/usr/local/bin/handle_jnlp.sh</string>
    </array>

    <key>UserName</key>
    <string>$username</string>

    <key>QueueDirectories</key>
    <array>
        <string>$watchpath</string>
    </array>

    <key>StandardErrorPath</key>
    <string>/tmp/com.apololab.handlejnlp.err</string>

    <key>StandardOutPath</key>
    <string>/tmp/com.apololab.handlejnlp.out</string>
</dict>
</plist>
EOT

echo "XML file generated: $output_file"

