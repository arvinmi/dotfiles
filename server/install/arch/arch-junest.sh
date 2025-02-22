# turn off bashrc "junest" alias
# git clone https://github.com/fsquillace/junest.git ~/.local/share/junest
# junest setup

# move to root of dotfiles dir
cd $HOME/dotfiles/

echo "Who am I"
sudoj whoami

# modify mirror URL to speed up downloads
sudoj echo 'Server = https://download.nus.edu.sg/mirror/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist

# refresh packages
sudoj pacman -Syyu --noconfirm
sudoj pacman -S --noconfirm archlinux-keyring

# install packages
sudoj pacman -S --noconfirm --ignore sudo glibc base base-devel ldns make autoconf man unzip wget tar lua luarocks \
neovim vim htop btop bind git python python-pynvim nodejs npm ruby gnu-free-fonts neofetch
# yay -Yc
yay -Sy
