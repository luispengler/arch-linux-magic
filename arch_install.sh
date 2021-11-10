# == MY ARCH SETUP INSTALLER == #
#part1
pacman --noconfirm -Sy archlinux-keyring
loadkeys us
timedatectl set-ntp true
lsblk
echo "Enter the drive (e.g /dev/sda or /dev/nvme0n1):  "
read drive
cfdisk $drive 
echo "Enter the linux partition: "
read partition
mkfs.ext4 $partition 
read -p "Did you also create efi partition? [Y/n]   " answer
if [[ $answer = y ]] ; then
  echo "Enter EFI partition (e.g /dev/sda1/):  "
  read efipartition
  mkfs.vfat -F 32 $efipartition
fi
mount $partition /mnt 
pacstrap /mnt base base-devel linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab
sed '1,/^#part2$/d' arch_install.sh > /mnt/arch_install2.sh
chmod +x /mnt/arch_install2.sh
arch-chroot /mnt ./arch_install2.sh
exit 

#part2
ln -sf /usr/share/zoneinfo/America/Campo_Grande /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "pt_BR.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "LC_NUMERIC=pt_BR.UTF-8" >> /etc/locale.conf
echo "LC_TIME=pt_BR.UTF-8" >> /etc/locale.conf
echo "LC_MONETARY=pt_BR.UTF-8" >> /etc/locale.conf
echo "LC_PAPER=pt_BR.UTF-8" >> /etc/locale.conf
echo "LC_NAME=pt_BR.UTF-8" >> /etc/locale.conf
echo "LC_ADDRESS=pt_BR.UTF-8" >> /etc/locale.conf
echo "LC_TELEPHONE=pt_BR.UTF-8" >> /etc/locale.conf
echo "LC_MEASUREMENT=pt_BR.UTF-8" >> /etc/locale.conf
echo "LC_IDENTIFICATION=pt_BR.UTF-8" >> /etc/locale.conf
echo "KEYMAP=br-abnt2" >> /etc/vconsole.conf
echo "Hostname: "
read hostname
echo $hostname > /etc/hostname
curl https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn/hosts > /etc/hosts
mkinitcpio -P
passwd
pacman --noconfirm -S grub efibootmgr os-prober
read -p "Installing UEFI? [Y/n]   " answer
if [[ $answer = y ]] ; then
  echo "Enter EFI partition: " 
  read efipartition
  mkdir /boot/efi
  mount $efipartition /boot/efi 
  grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
  sed -i 's/quiet/pci=noaer/g' /etc/default/grub
  sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
  grub-mkconfig -o /boot/grub/grub.cfg
fi
echo "Enter drive to install grub: "
read drive
grub-install $drive
exit 

pacman -S --noconfirm xorg-server xorg-xinit xorg-xkill xorg-xsetroot xorg-xbacklight xorg-xprop \
     noto-fonts noto-fonts-emoji noto-fonts-cjk ttf-jetbrains-mono ttf-joypixels ttf-font-awesome \
     sxiv mpv zathura zathura-pdf-mupdf ffmpeg imagemagick  \
     fzf man-db xwallpaper python-pywal youtube-dl unclutter xclip maim \
     zip unzip unrar p7zip xdotool papirus-icon-theme brightnessctl  \
     dosfstools ntfs-3g git sxhkd zsh pipewire pipewire-pulse \
     vim emacs arc-gtk-theme rsync firefox dash \
     xcompmgr libnotify dunst slock jq \
     dhcpcd networkmanager rsync pamixer

systemctl enable NetworkManager.service 
rm /bin/sh
ln -s dash /bin/sh
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
echo "Enter Username: "
read username
useradd -m -G wheel -s /bin/zsh $username
passwd $username
echo "Pre-Installation Finish Reboot now"
ai3_path=/home/$username/arch_install3.sh
sed '1,/^#part3$/d' arch_install2.sh > $ai3_path
chown $username:$username $ai3_path
chmod +x $ai3_path
su -c $ai3_path -s /bin/sh $username
exit 

#part3
cd $HOME
git clone --separate-git-dir=$HOME/.dotfiles https://github.com/bugswriter/dotfiles.git tmpdotfiles
rsync --recursive --verbose --exclude '.git' tmpdotfiles/ $HOME/
rm -r tmpdotfiles
git clone --depth=1 https://github.com/Bugswriter/dwm.git ~/.local/src/dwm
sudo make -C ~/.local/src/dwm install
git clone --depth=1 https://github.com/Bugswriter/st.git ~/.local/src/st
sudo make -C ~/.local/src/st install
git clone --depth=1 https://github.com/Bugswriter/dmenu.git ~/.local/src/dmenu
sudo make -C ~/.local/src/dmenu install
git clone --depth=1 https://github.com/Bugswriter/baph.git ~/.local/src/baph
sudo make -C ~/.local/src/baph install
baph -inN libxft-bgra-git

ln -s ~/.config/x11/xinitrc .xinitrc
ln -s ~/.config/shell/profile .zprofile
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mv ~/.oh-my-zsh ~/.config/zsh/oh-my-zsh
rm ~/.zshrc ~/.zsh_history
mkdir -p ~/dl ~/vids ~/music ~/dox ~/code ~/pix/ss
alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dots config --local status.showUntrackedFiles no
exit
