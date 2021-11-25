#!/bin/bash
cat << "EOF"
 _    _ _    _ _             _
 | |  (_) |  (_) |           (_)
 | | ___| | ___| | ___   __ _ _ _ __
 | |/ / | |/ / | |/ _ \ / _` | | '_ \
 |   <| |   <| | | (_) | (_| | | | | |
 |_|\_\_|_|\_\_|_|\___/ \__, |_|_| |_|
                         __/ |
                        |___/
EOF

echo "Removing old version of KikiLogin if installed..."
rm -rf /Applications/KikiLogin.app
echo "Installing KikiLogin....."
if ! command -v brew &> /dev/null
then
    echo "Homebrew not found! Installing Homebrew"
    echo -ne '\n' | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    echo "Install Homebrew success!"
    exit
fi
echo "Checking for NodeJS"
if ! command -v node &> /dev/null
then
    echo "NodeJS not found! Installing NodeJS..."
    brew install node
    echo "Install NodeJS success!"
    exit
fi
echo "Checking for KikiLogin dependencies..."
echo "KikiLogin will be installed to $HOME/Documents/chrome-mac"
rm -rf "$HOME/Documents/chrome-mac/"
mkdir "$HOME/Documents/chrome-mac"
cd "$HOME/Documents/chrome-mac/"
curl -L https://github.com/kikilogin/kikiinstaller-macos/releases/download/v1.0/kikilogin.zip > file.zip
echo "Finished download KikiLogin. Extracting..."
unzip -q file.zip
rm file.zip
echo "Installing KikiLogin dependencies..."
PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true npm i &> /dev/null
echo "Copy KikiLogin app to App folder...."
cp -R KikiLogin.app /Applications/KikiLogin.app
echo "Finished!"