#! /bin/bash
# ApoloLab's JNLP Launcher for OSX
# Developed by: Dani3l Murill0
osascript -e 'display notification "Por favor, espere..." with title "DrsBee" subtitle "Inicializando módulo de firma digital" sound name "Submarine"'
jnlpURL="https://dev.drsbee.com/es-CR/Account/DoSignatureLogin?contextData=$1";
echo $jnlpURL;
#jnlpURL="https://www.drsbee.com/es-CR/Account/DoSignatureLogin?contextData=QVNQLk5FVF9TZXNzaW9uSWQ9REVFODg4MEJBQ0M3MDgxNTA4NDA0MDZEOyBfZ2FfWUtIS1hNTERaSD1HUzEuMS4xNjQzMjExNjAwLjEuMC4xNjQzMjExNjAwLjA7IF9nYT1HQTEuMi4xMDgxOTk4NDk3LjE2NDMyMTE2MDE7IF9naWQ9R0ExLjIuMTUyMDQ5NTc2Mi4xNjQzMjExNjAyOyBfZ2F0X2d0YWdfVUFfMTc4NjQ0OTU1XzI9MTsgX2hqU2Vzc2lvblVzZXJfMjAwNDkxOD1leUpwWkNJNkltVXlaamhsTkRJMExUTTNaall0TldSaFpDMDVNemRqTFRFMFpETmlOekEwT0Rsa05pSXNJbU55WldGMFpXUWlPakUyTkRNeU1URTJNREUxTnpJc0ltVjRhWE4wYVc1bklqcG1ZV3h6WlgwPTsgX2hqRmlyc3RTZWVuPTE7IF9oakluY2x1ZGVkSW5TZXNzaW9uU2FtcGxlPTE7IF9oalNlc3Npb25fMjAwNDkxOD1leUpwWkNJNklqUTVZekkwTURWbExUSTJaVGt0TkdGa01DMWhaREJsTFRsa01UZzROalJpTnpOak15SXNJbU55WldGMFpXUWlPakUyTkRNeU1URTJNREUzTkRVc0ltbHVVMkZ0Y0d4bElqcDBjblZsZlE9PTsgX2hqSW5jbHVkZWRJblBhZ2V2aWV3U2FtcGxlPTE7IF9oakFic29sdXRlU2Vzc2lvbkluUHJvZ3Jlc3M9MQ=="
curl -o "/tmp/BeeSignerLauncher.jnlp" -L "$jnlpURL"
xattr -d com.apple.quarantine "/tmp/BeeSignerLauncher.jnlp"
#nohup open "/Applications/OpenWebStart/OpenWebStart javaws.app" "~/Downloads/BeeSignerLauncher.jnlp" >/dev/null 2>&1 &
open "/Applications/OpenWebStart/OpenWebStart javaws.app" "/tmp/BeeSignerLauncher.jnlp" > /Users/daniel/beesigner.log
