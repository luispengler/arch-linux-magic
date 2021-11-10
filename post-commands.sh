#!/bin/sh

setxkbmap -model thinkpad -layout br
pacman -S --noconfirm discord ripgrep fd 
baph -ianN yay brave-bin #Installs brave and yay
## Add entry for doom emacs.
## git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
## ~/.emacs.d/bin/doom install

## Create a way to download app images. e.g some wget or curl.
