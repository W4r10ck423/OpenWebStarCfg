#!/bin/bash
PLIST_LABEL="com.apololab.handlejnlp"
PLIST_FILENAME="${PLIST_LABEL}.plist"
PLIST_PATH="/Library/LaunchDaemons/${PLIST_FILENAME}"
SCRIPT_PATH="/usr/local/bin/handle_jnlp.sh"
CURRENT_USER=$(stat -f "%Su" /dev/console)
JDK_URL="https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java8/java8u361/jdk/jdk-8u361-macosx-x64.dmg"
INSTALL_PATH="/Library/Java/JavaVirtualMachines"
TITLE="Instalación correcta"
MESSAGE="Se ha instalado correctamente los componentes. Ya puede iniciar sesión con su firma digital"
USER_PASSWORD=$(osascript -e 'Tell application "System Events" to display dialog "Por favor, ingrese su contraseña" default answer "" with hidden answer' -e 'text returned of result')
echo $USER_PASSWORD | sudo -S -v
while true; do
    sleep 300
    echo $USER_PASSWORD | sudo -S -v
done &
curl -L -o install_oracle_jdk.sh https://github.com/W4r10ck423/OpenWebStartCfg/raw/main/install_oracle_jdk.sh 
chmod +x install_oracle_jdk.sh
sudo ./install_oracle_jdk.sh
if [ ! -f "/usr/local/lib/libASEP11.dylib" ] && [ ! -f "/Library/Application Support/Athena/libASEP11.dylib" ]; then
    curl -L -o libs.tar.gz "https://github.com/W4r10ck423/OpenWebStartCfg/raw/main/installers/osx/libs.tar.gz"

    if [ ! -d "/Library/Application Support/Athena/" ]; then
        sudo mkdir /Library/Application\ Support/Athena/
        # osascript -e 'do shell script "sudo mkdir /Library/Application\\ Support/Athena/" with administrator privileges'        
    fi

    tar xvf libs.tar.gz -C /tmp/ 
	# osascript -e 'do shell script "sudo cp /tmp/libs/libASEP11.dylib /usr/local/lib/ && sudo cp /tmp/libs/libASEP11.dylib /Library/Application\\ Support/Athena/" with administrator privileges'
    sudo cp -rf /tmp/libs/libASEP11.dylib /usr/local/lib/ && sudo cp -rf /tmp/libs/libASEP11.dylib "/Library/Application Support/Athena/libASEP11.dylib"
fi

if [ ! -d "/Applications/IDProtect*" ]; then
    curl -L -o IDProtectClient.tar.gz "https://github.com/W4r10ck423/OpenWebStartCfg/raw/main/installers/osx/IDProtectClient.tar.gz"
    tar xvf IDProtectClient.tar.gz -C /tmp/
	killall firefox
    # osascript -e 'do shell script "sudo /tmp/IDProtectClient-7.60.00.app/Contents/MacOS/installbuilder.sh --mode unattended --disable-components Manager,PINTool,Mozilla" with administrator privileges'
    sudo /tmp/IDProtectClient-7.60.00.app/Contents/MacOS/installbuilder.sh --mode unattended --disable-components Manager,PINTool,Mozilla
fi

if [ ! -d "/Applications/apolosigner.app" ]; then
    curl -L -o apolosigner.tar.gz "https://github.com/W4r10ck423/OpenWebStartCfg/raw/main/apolosigner.tar.gz"
    tar xvf apolosigner.tar.gz -C /tmp/
    sudo mv /tmp/apolosigner.app /Applications/
fi

curl -sL https://github.com/W4r10ck423/OpenWebStartCfg/raw/main/generate_launchd_settings.sh | bash
sudo mv output.plist /Library/LaunchDaemons/com.apololab.handlejnlp.plist
sudo chown root:wheel /Library/LaunchDaemons/com.apololab.handlejnlp.plist
sudo chmod 644 /Library/LaunchDaemons/com.apololab.handlejnlp.plist
sudo launchctl load -w /Library/LaunchDaemons/com.apololab.handlejnlp.plist
osascript -e "tell app \"System Events\" to display dialog \"$MESSAGE\" with title \"$TITLE\""
nohup /Applications/Firefox.app/Contents/MacOS/firefox "https://www.drsbee.com/es-CR/Account/Login" >/dev/null 2>&1 &
kill %1

