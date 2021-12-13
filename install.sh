#!/bin/bash
cat << "EOF"
 _  ___ _    _ _                 _
 | |/ (_) |  (_) |               (_)
 | ' / _| | ___| |     ___   __ _ _ _ __
 |  < | | |/ / | |    / _ \ / _` | | '_ \
 | . \| |   <| | |___| (_) | (_| | | | | |
 |_|\_\_|_|\_\_|______\___/ \__, |_|_| |_|
                             __/ |
                            |___/
EOF

echo "Removing old version of KikiLogin if installed..."
echo "KikiLogin will be installed to $HOME/Documents/chrome-mac"
rm -rf "$HOME/Documents/chrome-mac/"
mkdir "$HOME/Documents/chrome-mac"
cd "$HOME/Documents/chrome-mac/"
rm -rf nodejs.pkg
rm -rf file.zip
rm -rf /Applications/KikiLogin.app
echo "Installing KikiLogin....."
echo "Checking for NodeJS"
if ! command -v node &> /dev/null
then
    echo "NodeJS not found! Installing NodeJS..."
    curl -L --progress-bar https://nodejs.org/download/release/v14.17.5/node-v14.17.5.pkg > nodejs.pkg
    installer -pkg nodejs.pkg -target CurrentUserHomeDirectory
    echo "Install NodeJS success!"
fi
echo "Checking for KikiLogin dependencies..."
curl -L --progress-bar https://github.com/kikilogin/kikiinstaller-macos/releases/download/v1.0/kikilogin.zip > file.zip
echo "Finished download KikiLogin. Extracting..."
unzip -q file.zip
echo "Installing KikiLogin dependencies..."
PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true npm i &> /dev/null
echo "Copy KikiLogin app to App folder...."
cp -R KikiLogin.app /Applications/KikiLogin.app
rm -rf nodejs.pkg
rm -rf file.zip
echo "Finished!"