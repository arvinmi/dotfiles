#!/usr/bin/env bash

######################### * Installation Instructions * ########################

# * TODO: (initial install, please consult help file)
# git config --global credential.helper store
# git clone https://github.com/arvinmi/dotfiles.git dotfiles
# cd dotfiles/devserver/install/ubuntu
# chmod +x ubuntu0-no-graphics.sh
# sh ubuntu0-no-graphics.sh

# * TODO: (rebuild)
# cd dotfiles/devserver/install/ubuntu
# sh ubuntu0-no-graphics.sh

############################## System Configuration #############################

echo "Hello $(whoami)! Let's get you set up."

# move to root of dotfiles dir
cd $HOME/dotfiles/

# Ask for the administrator password upfront (undo if necessary)
sudo -v

echo "* install/remove packages *"
# install packages (apt-mark showmanual)
sudo apt-get update && sudo apt-get upgrade -y
sudo apt install -y build-essential htop fzf git golang pgcli rclone iptables ncdu \
neofetch neovim fail2ban ranger tree tmux glances vim curl plocate net-tools \
openssh-server python3-pip trash-cli gdb
# if graphics needed
# sudo apt-get install -y lxqt-core sddm
# remove stock software
# sudo apt-get remove

# setup ssh
# sudo apt-get install ethtool
systemctl enable ssh
sudo ufw allow ssh

echo "install zt"
curl -s https://install.zerotier.com | sudo bash
curl -s http://download.zerotier.com/contact%40zerotier.com.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/zerotier.com.gpg > /dev/null
# sudo zerotier-cli join $ID

echo "install miniconda"
# cd Downloads
# wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.12.0-Linux-x86_64.sh
# chmod +x Miniconda3-py39_4.12.0-Linux-x86_64.sh
# bash ./Miniconda3-py39_4.12.0-Linux-x86_64.sh
# conda config --add channels conda-forge
# conda config --set channel_priority strict

echo "install sdkman"
# curl -s "https://get.sdkman.io" | bash
# sdk version

echo "install tpm"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# stow devserver files
for file in "bash"; do
  stow --verbose --target="$HOME" --dir="devserver" --restow "$file"
done

# stow common files
for file in "vim" "nvim" "tmux"; do
  stow --verbose --target="$HOME" --dir="common" --restow "$file"
done

# tmux source file
tmux source-file ~/.tmux.conf

# nvim install autoformatters
# install "stylua", "black", "clang-format", "prettier"

# setup kvm
# echo "* install qemu/kvm packages *"
# sudo apt-get install -y virt-manager

# disable autosuspend for usb devices
sudo modprobe usbcore autosuspend=-1

# increase jigahertz 
# sudo apt-get install linux-tools-5.15.0-41-generic (change to latest)
# sudo cpupower frequency-set -g performance

# set nvidia-smi pl
# git clone https://github.com/arvinmi/devops-resources.git
# sudo cp "${HOME}/devops-resources/devserver/sys/nvidia-tdp.service" "/etc/systemd/system/"
# sudo cp "${HOME}/devops-resources/devserver/sys/nvidia-tdp.timer" "/etc/systemd/system/" 
# nvidia-smi -pm 1
# sudo systemctl daemon-reload
# sudo systemctl enable --now nvidia-tdp.timer

echo "* install flatpak *"
sudo apt-get install -y flatpak gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak list
# flatpak install

############################# SSH Configuration ###############################

echo "configure ssh config"

sudo bash -c 'cat >> /etc/ssh/sshd_config << EOF
# AllowTcpForwarding yes (for third-party apps)
IgnoreRhosts yes
LoginGraceTime 120
LogLevel VERBOSE
MaxAuthTries 5
MaxStartups 5
# Port 22
Protocol 2
PermitEmptyPasswords no
PermitRootLogin no
PrintLastLog no
PrintMotd no
PasswordAuthentication no
UsePAM yes
# X11Forwarding no
# Subsystem sftp  /usr/lib/openssh/sftp-server
EOF'

sudo systemctl reload ssh.service
exit

################################# Post Setup ##################################

# set up firewall
# sudo systemctl enable ufw
# sudo ufw enable

# add on client machine for jupynotebooks
# ssh -N -f -L 8888:localhost:9000 $USER@$HOSTNAME

# change grub at /etc/default/grub
# GRUB_TIMEOUT_STYLE=menu
# GRUB_TIMEOUT=5
# sudo update-grub

echo "           /(| "
echo "          (  : "
echo "         __\  \  _____ "
echo "       (____)  \| "
echo "      (____)|   | "
echo "       (____).__| "
echo "        (___)__.|_____ "

echo " "
echo "Done. Note that some of these changes require a logout/restart to take effect."

print "TODO:\n\
configure: \n\
install lm-sensors for prox \n\
install miniconda \n\
change grub timeout to \n\
set cpupower for kernal \n\
install flatpak packages (refer above) \n\
check all symlinked files \n\
dotfiles test sync \n\
perform reboot \n\
\n\
login to literally everything \n\
attach; any other dotfiles from your repo/re-login \n\
"
