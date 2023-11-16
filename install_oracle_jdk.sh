#!/bin/bash

# Define the URL and the installation path
JDK_URL="https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java8/java8u361/jdk/jdk-8u361-macosx-x64.dmg"
DMG_FILE="jdk-8u361-macosx-x64.dmg"
INSTALL_PATH="/Library/Java/JavaVirtualMachines"

# Download the JDK using curl
echo "Downloading Oracle JDK..."
curl -L -o "$DMG_FILE" $JDK_URL

# Check if the download was successful
if [ ! -f "$DMG_FILE" ]; then
    echo "Download failed. DMG file not found."
    exit 1
fi

# Mount the downloaded DMG file
echo "Mounting DMG file..."
MOUNT_DIR=`hdiutil attach jdk-8u361-macosx-x64.dmg -nobrowse -noautoopen -noverify -mountpoint /Volumes/jdk-8u361-macosx-x64 | grep "Volumes" | awk '{print $3}'`

# Check if the mounting was successful
if [ -z "$MOUNT_DIR" ]; then
    echo "Failed to mount DMG file."
    exit 1
fi

# Perform silent installation using osascript for administrative privileges
echo "Installing JDK..."
cp -rf $MOUNT_DIR/*.pkg /tmp/oracle-jdk.pkg
sudo installer -pkg /tmp/oracle-jdk.pkg -target /
# Eject the mounted image
hdiutil detach "$MOUNT_DIR"

# Clean up downloaded file
rm "$DMG_FILE"

echo "Installation complete."
