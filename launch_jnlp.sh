#! /bin/bash
# ApoloLab's JNLP Launcher for OSX
# Developed by: Dani3l Murill0
jnlpURL="https://dev.drsbee.com/es-CR/Account/DoSignatureLogin?contextData=QVNQLk5FVF9TZXNzaW9uSWQ9QzNBOTFFMTBBMzE0RTEwREE5MTZDMUQx";
curl -o "DrsbeeSignatureLauncher.jnlp" -L "$jnlpURL"
xattr com.apple.quarantine "DrsbeeSignatureLauncher.jnlp"
nohup open "/Applications/OpenWebStart/OpenWebStart javaws.app" "DrsbeeSignatureLauncher.jnlp" &
