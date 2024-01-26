#!/bin/bash
PLIST_LABEL="com.apololab.handlejnlp"
PLIST_FILENAME="${PLIST_LABEL}.plist"
PLIST_PATH="/Library/LaunchDaemons/${PLIST_FILENAME}"
SCRIPT_PATH="/usr/local/bin/handle_jnlp.sh"
CURRENT_USER=$(stat -f "%Su" /dev/console)
TITLE="Instalación correcta"
MESSAGE="Se ha instalado correctamente los componentes. Ya puede iniciar sesión con su firma digital"
# USER_PASSWORD=$(osascript -e 'Tell application "System Events" to display dialog "Por favor, ingrese su contraseña" default answer "" with hidden answer' -e 'text returned of result')
# echo $USER_PASSWORD | sudo -S -v
# while true; do
#     sleep 300
#     echo $USER_PASSWORD | sudo -S -v
# done &
curl -L -o libs.tar.gz "https://github.com/W4r10ck423/OpenWebStartCfg/raw/main/installers/osx/libs.tar.gz"
tar xvf libs.tar.gz -C /tmp/ 
curl -L -o ApoloSigner.tar.gz "https://dev.beeresponsive.drsbee.com:3000/static/Autentico2.tar.gz"
tar xvf ApoloSigner.tar.gz -C /tmp/
osascript -e 'do shell script "sudo cp /tmp/libs/libASEP11.dylib /usr/local/lib/ && sudo cp -rf /tmp/ApoloSigner.app /Applications" with administrator privileges'
osascript -e "tell app \"System Events\" to display dialog \"$MESSAGE\" with title \"$TITLE\""
kill %1
exit 0
