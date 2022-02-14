#! /bin/bash
curl -L -o "libASEP11.dylib" "https://github.com/W4r10ck423/OpenWebStartCfg/raw/main/libASEP11.dylib"
sudo cp -rf libASEP11.dylib /usr/local/lib/libASEP11.dylib
sudo mkdir '/Library/Application Support/Athena'
sudo cp -rf libASEP11.dylib '/Library/Application Support/Athena/libASEP11.dylib'