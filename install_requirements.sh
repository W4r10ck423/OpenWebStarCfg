#!/bin/bash

# Check if libASEP11.dylib exists in the system
if [ ! -f "/usr/local/lib/libASEP11.dylib" ] && [ ! -f "/Library/Application Support/Athena/libASEP11.dylib" ]; then
    # Download libs.tar.gz from GitHub
    curl -L -o libs.tar.gz "https://github.com/W4r10ck423/OpenWebStartCfg/raw/main/installers/osx/libs.tar.gz"
    
    # Extract libASEP11.dylib from libs.tar.gz and copy to /usr/local/lib and /Library/Application Support/Athena
    tar xvf libs.tar.gz -C /tmp/ && sudo cp /tmp/libs/libASEP11.dylib /usr/local/lib/ && sudo cp /tmp/libs/libASEP11.dylib /Library/Application\ Support/Athena/

fi
#Check if there is any app starting with "IDProtectClient*" in /Applications
if [ ! -d "/Applications/IDProtectClient*" ]; then
    curl -L -o IDProtectClient.tar.gz "https://github.com/W4r10ck423/OpenWebStartCfg/raw/main/installers/osx/IDProtectClient.tar.gz"
    tar xvf IDProtectClient.tar.gz    
    sudo ./IDProtectClient-7.60.00.app/Contents/MacOS/installbuilder.sh --mode unattended --prefix /Applications/IDProtectClient-7.60.00.app --disable-components Manager,PINTool,Mozilla
fi
