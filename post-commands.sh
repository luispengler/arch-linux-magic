#!/bin/sh

setxkbmap -model thinkpad -layout br
pacman -S --noconfirm discord wget ripgrep fd kdeconnect
baph -ianN yay brave-bin #Installs brave and yay
## Add entry for doom emacs.
## git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
## ~/.emacs.d/bin/doom install

## Downloading AppImages
# You should make multiple connections to get faster download
cd ~/lg/AppImages/
wget https://download.kde.org/stable/kdenlive/21.08/linux/kdenlive-21.08.3-x86_64.appimage
wget 
