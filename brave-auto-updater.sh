#!/bin/bash
#
RED="\e[31m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"


update_browser() {

    echo "--> Removing previous temp folder"
    rm -rf ~/Downloads/000bravetemp

    echo "--> Creating temp folder"
    mkdir -p ~/Downloads/000bravetemp

    echo "--> Brave browser will be installed at ~/.opt/brave/"
    mkdir -p ~/.opt/brave
    cd ~/Downloads/000bravetemp

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
    cp -TR brave ~/.opt/brave

    echo "--> Removing temp folder"
    rm -rf ~/Downloads/000bravetemp

    echo "---: Completed :---"

    echo "Note: put 'brave-browser.desktop' manually to ~/.local/share/applications/"

}


FILE=/home/$USER/.opt/brave/brave-browser
if [ -f "$FILE" ]; then

    cd ~/.opt/brave
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
    echo "-->Brave not installed or Not found at ~/.opt/brave/"

    echo "-->Do you want to install Brave Browser?"
    select yn in "Yes" "No"; do
    case $yn in
        Yes ) update_browser; break;;
        No ) exit;;
    esac
    done
fi



