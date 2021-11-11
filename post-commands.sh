#!/bin/sh

setxkbmap -model thinkpad -layout br
pacman -S --noconfirm emacs discord thunar gvfs transmission-gtk kdeconnect wget python2 xdg-user-dirs ripgrep fd
baph -ianN yay brave-bin #Installs brave and yay
## Add entry for doom emacs.
## git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
## ~/.emacs.d/bin/doom install

## Installing LaTeX stuff
pacman -S textlive-most texlive-lang
baph -i vim-pathogen vim-live-latex-support


## XDG User entries
xdg-user-dirs-update
## Add remaining entries (automate this)

## Downloading AppImages
# You should make multiple connections to get faster download
cd ~/lg/appimages
mkdir kdenlive
cd ~/lg/appimages/kdenlive
wget https://download.kde.org/stable/kdenlive/21.08/linux/kdenlive-21.08.3-x86_64.appimage
mkdir betterdiscord
cd ~/lg/appimages/betterdiscord
wget https://github.com/BetterDiscord/Installer/releases/latest/download/BetterDiscord-Linux.AppImage

## Git Cloning
cd ~/lg/gitclones/ ## Firefox secure profile
git clone https://github.com/arkenfox/user.js.git
git clone --depth 1 https://github.com/matteoguarda/telegram-palette-gen ~/.telegram-palette-gen ## Telegram pywal
cd ~/.telegram-palette-gen 
./telegram-palette-gen
cd ~/lg/gitclones/ ## Speedtest cli
git clone https://github.com/sivel/speedtest-cli.git
cd speedtest-cli
python setup.py install
cd ~/lg/gitclones/
## 
cd
