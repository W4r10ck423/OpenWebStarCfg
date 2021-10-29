#! /bin/bash
# ApoloLab's OpenWebStart Unattended Installation Script
# Developed by: Dani3l Murill0
echo "------WELCOME TO OPENWEBSTART INSTALLATION SCRIPT------"
echo "-----------------------APOLOLAB------------------------"
installerURL=$(curl -sL https://api.github.com/repos/karakun/OpenWebStart/releases/latest | grep "/OpenWebStart_macos" | cut -d\" -f4)
installerVersion=$(echo $installerURL | cut -d\/ -f8)
installerFile=$(echo $installerURL | cut -d\/ -f9)
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

echo "[INFO] Performing unattended install, please wait..."
hdiutil attach $installerFile 
/Volumes/OpenWebStart/OpenWebStart\ Installer.app/Contents/MacOS/JavaApplicationStub -q -varfile response.varfile
hdiutil detach /Volumes/OpenWebStart
echo "[INFO] Downloading aditional configuration file, please wait..."
curl -L -o "$HOME/.config/icedtea-web/deployment.properties" "https://raw.githubusercontent.com/W4r10ck423/OpenWebStartCfg/main/deployment.properties"
curl -L -o "DoSignatureLogin.jnlp" "https://www.drsbee.com/es-CR/Account/DoSignatureLogin?contextData=X2dhX1lLSEtYTUxEWkg9R1MxLjEuMTYzMzc0Njc0MS4xNy4wLjE2MzM3NDY3NDEuMDsgX2dhPUdBMS4yLjE4Mjk1Njc0MDQuMTYzMjc3MTI2MjsgX2hqaWQ9NTIwN2Q1MWItMjQ5YS00NTQ4LTg0NzMtOTk2ODcyZmZjYWI5O0FTUC5ORVRfU2Vzc2lvbklkPTBENzJGQzc2REM2MUEzQjBCNTdBRjlFRQ=="
echo "[INFO] Cleaning installation resources..."
rm -rf response.varfile $installerFile
echo "[INFO] Running app for the first time..."
open -a "OpenWebStart javaws" DoSignatureLogin.jnlp --args -Xoffline
