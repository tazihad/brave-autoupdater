#!/bin/bash
#
RED="\e[31m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"

INSTALLATION_DIRECTORY="/home/$USER/.opt/brave"
TEMP_DIRECTORY="/home/$USER/Downloads/000bravetemp"

download_browser(){
    echo "--> Removing previous temp folder"
    rm -rf $TEMP_DIRECTORY

    echo "--> Creating temp folder"
    mkdir -p $TEMP_DIRECTORY

    echo "--> Brave browser will be installed at $INSTALLATION_DIRECTORY/"
    mkdir -p $INSTALLATION_DIRECTORY
    cd $TEMP_DIRECTORY

    echo "--> Searching and downloading latest stable Brave Browser from https://github.com/brave/brave-browser/releases"
    wget -O brave.deb -q --show-progress https://github.com/brave/brave-browser/releases/download/v"$(curl -s https://brave-browser-downloads.s3.brave.com/latest/release.version)"/brave-browser_"$(curl -s https://brave-browser-downloads.s3.brave.com/latest/release.version)"_amd64.deb

    echo "--> Extracting browser"
    ar x brave.deb data.tar.xz
    echo "--> brave.deb extracting complete"
    tar -xf data.tar.xz
    echo "--> data.tar.xz extracting complete"
    gunzip usr/share/doc/brave-browser/changelog.gz
    cp usr/share/doc/brave-browser/changelog opt/brave.com/brave
    cd opt/brave.com

    echo "--> Moving Downloded files to installed directory"
    cp -TR brave $INSTALLATION_DIRECTORY/

    echo "--> Removing temp folder"
    rm -rf $TEMP_DIRECTORY

    echo "---: Download Completed :---"
}

install_browser(){

    download_browser;


    echo "Setting up..."
    cd $INSTALLATION_DIRECTORY
    for size in 16x16 24x24 32x32 48x48 64x64 128x128 256x256; do
    mkdir -p /home/$USER/.local/share/icons/hicolor/$size/apps
		cp -rf "product_logo_${size/x*/}.png" \
			"/home/$USER/.local/share/icons/hicolor/$size/apps/brave-desktop.png"
	done
    echo "Setting up application launcher icon"
    setup_application_launcher_icon;
    echo "---: Installation Completed :---"
}

update_browser() {

    download_browser;
    echo "---: Update Completed :---"
}

setup_application_launcher_icon(){

    touch "/home/$USER/.local/share/applications/brave-browser.desktop"
    FILE="/home/$USER/.local/share/applications/brave-browser.desktop"

cat <<EOM >$FILE

    [Desktop Entry]
    Version=1.0
    Name=Brave Web Browser
    GenericName=Web Browser
    Exec=/home/$USER/.opt/brave/brave-browser %U
    StartupNotify=true
    Terminal=false
    Icon=brave-desktop
    Type=Application
    Categories=Network;WebBrowser;
    MimeType=application/pdf;application/rdf+xml;application/rss+xml;application/xhtml+xml;application/xhtml_xml;application/xml;image/gif;image/jpeg;image/png;image/webp;text/html;text/xml;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/ipfs;x-scheme-handler/ipns;
    Actions=new-window;new-private-window;

    [Desktop Action new-window]
    Name=New Window
    Exec=/home/$USER/.opt/brave/brave-browser

    [Desktop Action new-private-window]
    Name=New Incognito Window
    Exec=/home/$USER/.opt/brave/brave-browser --incognito

EOM

}


FILE=$INSTALLATION_DIRECTORY/brave-browser
if [ -f "$FILE" ]; then

    cd $INSTALLATION_DIRECTORY
    echo -e "===> Installed version: "${RED}"$(grep -Po "(?<=tag/v)([0-9]|\.)*(?=\s|$)" changelog)"${ENDCOLOR}""
    echo -e "===> Latest version: "${RED}"$(curl -s https://brave-browser-downloads.s3.brave.com/latest/release.version)"${ENDCOLOR}""

    echo "Update browser?"
    select yn in "Yes" "No"; do
    case $yn in
        Yes ) update_browser; break;;
        No ) exit;;
    esac
    done

else
    echo "-->Brave not installed or Not found at $INSTALLATION_DIRECTORY/"

    echo "-->Do you want to install Brave Browser?"
    select yn in "Yes" "No"; do
    case $yn in
        Yes ) install_browser; break;;
        No ) exit;;
    esac
    done
fi



