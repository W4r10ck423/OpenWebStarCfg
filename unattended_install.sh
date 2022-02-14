#! /bin/bash
# ApoloLab's OpenWebStart Unattended Installation Script
# Developed by: Dani3l Murill0
echo "------WELCOME TO OPENWEBSTART INSTALLATION SCRIPT------"
echo "-----------------------APOLOLAB------------------------"
installerURL=$(curl -sL https://api.github.com/repos/karakun/OpenWebStart/releases/latest | grep "/OpenWebStart_macos" | cut -d\" -f4)
installerVersion=$(echo $installerURL | cut -d\/ -f8)
installerFile=$(echo $installerURL | cut -d\/ -f9)
#jnlpFile="https://dev.drsbee.com/es-CR/Account/DoSignatureLogin?contextData=QVNQLk5FVF9TZXNzaW9uSWQ9QzNBOTFFMTBBMzE0RTEwREE5MTZDMUQx" #DEV
jnlpFile="https://www.drsbee.com/es-CR/Account/DoSignatureLogin?contextData=QVNQLk5FVF9TZXNzaW9uSWQ9REVFODg4MEJBQ0M3MDgxNTA4NDA0MDZEOyBfZ2FfWUtIS1hNTERaSD1HUzEuMS4xNjQzMjExNjAwLjEuMC4xNjQzMjExNjAwLjA7IF9nYT1HQTEuMi4xMDgxOTk4NDk3LjE2NDMyMTE2MDE7IF9naWQ9R0ExLjIuMTUyMDQ5NTc2Mi4xNjQzMjExNjAyOyBfZ2F0X2d0YWdfVUFfMTc4NjQ0OTU1XzI9MTsgX2hqU2Vzc2lvblVzZXJfMjAwNDkxOD1leUpwWkNJNkltVXlaamhsTkRJMExUTTNaall0TldSaFpDMDVNemRqTFRFMFpETmlOekEwT0Rsa05pSXNJbU55WldGMFpXUWlPakUyTkRNeU1URTJNREUxTnpJc0ltVjRhWE4wYVc1bklqcG1ZV3h6WlgwPTsgX2hqRmlyc3RTZWVuPTE7IF9oakluY2x1ZGVkSW5TZXNzaW9uU2FtcGxlPTE7IF9oalNlc3Npb25fMjAwNDkxOD1leUpwWkNJNklqUTVZekkwTURWbExUSTJaVGt0TkdGa01DMWhaREJsTFRsa01UZzROalJpTnpOak15SXNJbU55WldGMFpXUWlPakUyTkRNeU1URTJNREUzTkRVc0ltbHVVMkZ0Y0d4bElqcDBjblZsZlE9PTsgX2hqSW5jbHVkZWRJblBhZ2V2aWV3U2FtcGxlPTE7IF9oakFic29sdXRlU2Vzc2lvbkluUHJvZ3Jlc3M9MQ==" #PROD
echo "[INFO] The current installer version is $installerVersion"
osascript -e 'display notification "(Este proceso puede tardar algunos minutos)" with title "DrsBee" subtitle "Por favor espere mientras se instalan los componentes requeridos" sound name "Submarine"'
curl -L -o "signer.xpi" "https://github.com/W4r10ck423/OpenWebStartCfg/raw/main/%7BC4113077-5495-4C77-A629-FFF0648EA6E5%7D.xpi"
signerPath="file://$(pwd)/signer.xpi"
/Applications/Firefox.app/Contents/MacOS/firefox --new-tab "$signerPath" &
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
curl -L -o "$HOME/.config/icedtea-web/deployment.properties" "https://raw.githubusercontent.com/W4r10ck423/OpenWebStartCfg/main/deployment.properties"
echo "[INFO] Performing unattended install, please wait..."
hdiutil attach $installerFile 
/Volumes/OpenWebStart/OpenWebStart\ Installer.app/Contents/MacOS/JavaApplicationStub -q -varfile response.varfile
hdiutil detach /Volumes/OpenWebStart
curl -L -o "DoSignatureLogin.jnlp" "$jnlpFile"
echo "[INFO] Cleaning installation resources..."
rm -rf response.varfile $installerFile
curl -L -o "handlers.json" "https://raw.githubusercontent.com/W4r10ck423/OpenWebStartCfg/main/handlers.json"
for handlerFile in $(find "$HOME/Library/ApplicationSupport/Firefox/Profiles" | grep "handlers.json")
do
cp -rf handlers.json "$handlerFile"
done
rm -rf handlers.json
echo "[INFO] Running app for the first time..."
killall firefox 
/Applications/Firefox.app/Contents/MacOS/firefox "$jnlpFile" "https://dev.drsbee.com/es-CR/Account/Login" &
#open -a "OpenWebStart javaws" DoSignatureLogin.jnlp --args -Xoffline
