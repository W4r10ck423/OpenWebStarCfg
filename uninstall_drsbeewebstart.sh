#! /bin/bash
sudo rm -rf $HOME/.cache/icedtea-web/* /Applications/websigner-launcher.app /Applications/OpenWebStart/ /Applications/IDProtectClient/ $HOME/.config/icedtea-web /Library/Application\ Support/Athena/ /usr/local/lib/libASEP11.dylib 
if [ -d "/Library/Java/JavaVirtualMachines/jdk1.8.0_361.jdk" ]; then
    sudo rm -rf /Library/Java/JavaVirtualMachines/jdk1.8.0_361.jdk
fi
if [ -f "/Library/LaunchDaemons/com.apololab.handlejnlp.plist" ]; then
    sudo launchctl unload /Library/LaunchDaemons/com.apololab.handlejnlp.plist
    sudo rm -rf /Library/LaunchDaemons/com.apololab.handlejnlp.plist
fi
if [ -d "$HOME/.local/share/apololab" ]; then
    sudo rm -rf $HOME/.local/share/apololab
fi
if [ -f "/Applications/apolosigner.app" ]; then
    sudo rm -rf /Applications/apolosigner.app
fi

