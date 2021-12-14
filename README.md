#### Brave Browser installer and updater script for linux.

**NOTE**
You should install Brave browser from [Official instruction](https://brave.com/linux/ "Official instruction").
Or Download from [Flatpak Beta](https://github.com/flathub/com.brave.Browser "Flatpak Beta") (Enable Flatpak Beta Repo)

Flatpak version of Brave Browser does not connect with KeepassXC and does not have hardware acceleration. But Native version solves this problem.

**This script is mainly intended for immutable system like Fedora Silverblue/Kinoite or Steam Deck.
** But other distro will also work.

You have to Manually run the script to install and update Browser.

 <br />
 
Script will only install Brave browser at `~/.opt/brave`
If you want to move directory. You have to do it manually inside the script.
To Get Application Launcher icon put `brave-browser.desktop` to `~/.local/share/application/`

To Delete and remove Brave Browser
```
rm -rf ~/.opt/brave
```
