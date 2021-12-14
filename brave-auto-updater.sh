#!/bin/bash
#

update_browser() {

    echo "--> Removing previous temp folder"
    rm -rf ~/Downloads/000bravetemp

    echo "--> Creating temp folder"
    mkdir -p ~/Downloads/000bravetemp

    echo "--> Brave browser will be installed at ~/.opt/brave/"
    mkdir -p ~/.opt/brave
    cd ~/Downloads/000bravetemp

    echo "--> Searching and downloading latest stable Brave Browser from https://github.com/brave/brave-browser/releases"
    wget -O brave.zip -q --show-progress https://github.com/brave/brave-browser/releases/download/v"$(curl -s https://brave-browser-downloads.s3.brave.com/latest/release.version)"/brave-browser-"$(curl -s https://brave-browser-downloads.s3.brave.com/latest/release.version)"-linux-amd64.zip

    echo "--> Unziping browser"
    unzip -qq brave.zip -d brave

    echo "--> Moving Downloded files to installed directory"
    cp -TR brave ~/.opt/brave

    echo "--> Removing temp folder"
    rm -rf ~/Downloads/000bravetemp

    echo "---: Completed :---"

    echo "Note: put 'brave-browser.desktop' manually to ~/.local/share/applications/"

}


FILE=/home/$USER/.opt/brave/brave-browser
if [ -f "$FILE" ]; then
    echo "Installed version: "$(~/.opt/brave/brave-browser --version)""
    echo "Latest version: "$(curl -s https://brave-browser-downloads.s3.brave.com/latest/release.version)""

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



