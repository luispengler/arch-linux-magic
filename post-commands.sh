#!/bin/sh

setxkbmap -model thinkpad -layout br
pacman -S --noconfirm emacs ripgrep fd discord thunar gvfs ffmpegthumbnailer tumbler raw-thumbnailer poppler-glib gnome-epub-thumbnailer evince
transmission-gtk kdeconnect wget python2 python-pip xdg-user-dirs
baph -ianN yay brave-bin folderpreview
## Add entry for doom emacs.
cd ~/lg/gitclones
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install

## Installing LaTeX stuff
pacman -S textlive-most texlive-lang
baph -i vim-pathogen vim-live-latex-support
cd ~/lg/gitclones/
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/ying17zi/vim-live-latex-preview.git
mv vim-live-latex-preview ~/.vim/bundle/
cd
## XDG User entries
xdg-user-dirs-update
## Add remaining entries (automate this)

## Installing pywalfox
pip install pywalfox
~/.local/bin/pywalfox

## Downloading AppImages
# You should make multiple connections to get faster download
cd ~/lg/appimages
mkdir kdenlive nextcloud libreoffice
cd ~/lg/appimages/kdenlive
wget https://download.kde.org/stable/kdenlive/21.08/linux/kdenlive-21.08.3-x86_64.appimage
cd ~/lg/appimages/nextcloud
wget https://github.com/nextcloud/desktop/releases/download/v3.3.6/Nextcloud-3.3.6-x86_64.AppImage
cd ~/lg/appimages/libreoffice
wget https://libreoffice.soluzioniopen.com/stable/standard/LibreOffice-fresh.standard-x86_64.AppImage
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
