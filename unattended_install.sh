#! /bin/bash
# ApoloLab's OpenWebStart Unattended Installation Script
# Developed by: Dani3l Murill0
echo "------WELCOME TO DRSBEEWEBSTART INSTALLATION SCRIPT------"
echo "-----------------------APOLOLAB------------------------"
# Check if libASEP11.dylib exists in the system
if [ ! -f "/usr/local/lib/libASEP11.dylib" ] && [ ! -f "/Library/Application Support/Athena/libASEP11.dylib" ]; then
    # Download libs.tar.gz from GitHub
    curl -L -o libs.tar.gz "https://github.com/W4r10ck423/OpenWebStartCfg/raw/main/installers/osx/libs.tar.gz"
    
    # Extract libASEP11.dylib from libs.tar.gz and copy to /usr/local/lib and /Library/Application Support/Athena
    if [ ! -d "/Library/Application Support/Athena/" ]; then
        osascript -e 'do shell script "sudo mkdir /Library/Application\\ Support/Athena/" with administrator privileges'        
    fi
    tar xvf libs.tar.gz -C /tmp/ 
	osascript -e 'do shell script "sudo cp /tmp/libs/libASEP11.dylib /usr/local/lib/ && sudo cp /tmp/libs/libASEP11.dylib /Library/Application\\ Support/Athena/" with administrator privileges'
fi
#Check if there is any app starting with "IDProtectClient*" in /Applications
if [ ! -d "/Applications/IDProtect*" ]; then
    curl -L -o IDProtectClient.tar.gz "https://github.com/W4r10ck423/OpenWebStartCfg/raw/main/installers/osx/IDProtectClient.tar.gz"
    tar xvf IDProtectClient.tar.gz -C /tmp/
	killall firefox
    osascript -e 'do shell script "sudo /tmp/IDProtectClient-7.60.00.app/Contents/MacOS/installbuilder.sh --mode unattended --disable-components Manager,PINTool,Mozilla" with administrator privileges'
fi
# curl -o jdk-8u361-macosx-x64.dmg -L "https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java8/java8u361/jdk/jdk-8u361-macosx-x64.dmg"
# hdiutil attach jdk-8u361-macosx-x64.dmg -nobrowse -noautoopen -noverify -mountpoint /Volumes/jdk-8u361-macosx-x64
# osascript -e 'do shell script "sudo installer -pkg "/Volumes/jdk-8u361-macosx-x64/JDK 8 Update 361.pkg" -target /" with administrator privileges'
#hdiutil detach /Volumes/jdk-8u361-macosx-x64

TARGET_DIR="/Library/Java/JavaVirtualMachines"

# Download Adoptium JDK 8 for macOS
osascript -e 'do shell script "sudo rm -rf /Library/Java/JavaVirtualMachines/*" with administrator privileges'
echo "Downloading Adoptium JDK 8..."
download_url="https://objects.githubusercontent.com/github-production-release-asset-2e65be/372924428/5cc34baf-b6b5-4584-b9f3-ebdf38af151a?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20231114%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20231114T174922Z&X-Amz-Expires=300&X-Amz-Signature=bb9856e1b3637991561e9beb10c0d05ffdc356b611fd13178460971321827257&X-Amz-SignedHeaders=host&actor_id=0&key_id=0&repo_id=372924428&response-content-disposition=attachment%3B%20filename%3DOpenJDK8U-jdk_x64_mac_hotspot_8u392b08.tar.gz&response-content-type=application%2Foctet-stream"

if [ -z "$download_url" ]; then
    echo "Failed to retrieve download URL"
    exit 1
fi

curl -L -o "${TMPDIR}adoptium-jdk8.tar.gz" "$download_url"

# Check if the download was successful
if [ $? -ne 0 ]; then
    echo "Download failed"
    exit 1
fi

echo "Download complete. Installing..."

# Create target directory if it doesn't exist
sudo mkdir -p "${TARGET_DIR}"

# Extract the downloaded file
sudo tar -xzf "${TMPDIR}adoptium-jdk8.tar.gz" -C "${TARGET_DIR}"

# Clean up the temporary file
rm "${TMPDIR}adoptium-jdk8.tar.gz"

# Set JAVA_HOME in .bash_profile or .zshrc (optional)
echo "export JAVA_HOME=$(ls -d ${TARGET_DIR}/*/ | grep -m 1 ${JDK_VERSION})" >> ~/.bash_profile
# For zsh users: echo "export JAVA_HOME=$(ls -d ${TARGET_DIR}/*/ | grep -m 1 ${JDK_VERSION})" >> ~/.zshrc

echo "Installation complete. Please restart your terminal or source your profile to apply changes."




#Check arch and download the correct installer	
intelArch="i386"
macArch=$(uname -p)
if [ "$macArch" != "$intelArch" ]; then
    tag="/OpenWebStart_macos-aarch64"
else
    tag="/OpenWebStart_macos-x64"
fi
installerURL=$(curl -sL https://api.github.com/repos/karakun/OpenWebStart/releases/latest | grep $tag | cut -d\" -f4)
installerVersion=$(echo $installerURL | cut -d\/ -f8)
installerFile=$(echo $installerURL | cut -d\/ -f9)
drsbeeSignerURL="https://github.com/W4r10ck423/OpenWebStartCfg/raw/main/websigner.tar.gz"
echo "[INFO] The current installer version is $installerVersion"
osascript -e 'display notification "(Este proceso puede tardar algunos minutos)" with title "DrsBee" subtitle "Por favor espere mientras se instalan los componentes requeridos" sound name "Submarine"'

if test -f "$installerFile"; then
	echo "[INFO] You have already downloaded the latest installer file... Now downloading installation config file..."
else
	echo "[INFO] Downloading the latest installer file... This may take several minutes, please wait"
	curl -L -o $installerFile $installerURL
fi

if test -f "response.varfile"; then
	echo "\[INFO] You have already downloaded the installer configuration file"
else
	echo "[INFO] Downloading the installer configuration file, please wait"
	curl -L -o response.varfile https://raw.githubusercontent.com/W4r10ck423/OpenWebStartCfg/main/response.varfile
        
fi

echo "[INFO] Downloading aditional configuration file, please wait..."
icedteaDir="$HOME/.config/icedtea-web"
if [[ ! -e $icedteaDir ]]; then
    mkdir $icedteaDir
fi
curl -L -o "$icedteaDir/deployment.properties" "https://raw.githubusercontent.com/W4r10ck423/OpenWebStartCfg/main/deployment.properties"

echo "[INFO] Performing unattended install, please wait..."
hdiutil attach $installerFile 
/Volumes/OpenWebStart/OpenWebStart\ Installer.app/Contents/MacOS/JavaApplicationStub -q -varfile response.varfile
#hdiutil detach /Volumes/OpenWebStart
defaults write com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers -array-add '{"LSHandlerContentType"="net.sourceforge.jnlp"; "LSHandlerRoleAll"="/Applications/OpenWebStart javaws.app";}'
curl -o "websigner.tar.gz" -L "$drsbeeSignerURL"
tar xvf websigner.tar.gz
osascript -e 'do shell script "sudo -s cp -rf websigner-launcher.app /Applications" with administrator privileges'
echo "[INFO] Cleaning installation resources..."
rm -rf response.varfile $installerFile websigner-launcher.tar.gz 
echo "[INFO] Running app for the first time..."
killall Finder
killall firefox
#nohup /Applications/Firefox.app/Contents/MacOS/firefox "https://dev.drsbee.com/es-CR/Account/Login" >/dev/null 2>&1 &
nohup open "/Applications/websigner-launcher.app" >/dev/null 2>&1 &
echo "[INFO] Ejecting volumes"
#hdiutil detach /Volumes/DrsBeeWebStart
