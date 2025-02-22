#!/usr/bin/env bash

######################### * Installation Instructions * ########################

# * TODO: (initial install for DE, please consult help file)
# git config --global credential.helper store
# git clone https://github.com/arvinmi/dotfiles.git dotfiles
# cd dotfiles/devserver/install/ubuntu
# chmod +x ubuntu0.sh
# sh ubuntu0.sh

# * TODO: (rebuild)
# cd dotfiles/devserver/install/ubuntu
# sh ubuntu0.sh

############################## System Configuration #############################

echo "Hello $(whoami)! Let's get you set up."

# Ask for the administrator password upfront (undo if necessary)
sudo -v

echo "* install/remove packages *"
# install packages (apt-mark showmanual)
sudo apt-get update && sudo apt-get upgrade -y
sudo apt install -y build-essential htop fzf git golang pgcli rclone iptables ncdu \
neofetch neovim fail2ban ranger tree tmux chromium-browser glances kitty gimp vim \
curl adwaita-icon-theme-full timeshift vorta plocate net-tools gnome-tweaks xterm \
openssh-server python3-pip python3-venv nodejs npm logisim trash-cli gdb clang \
llvm valgrind btop
# if neccessary
# sudo apt-get install -y timeshift vorta
# remove stock software 
sudo apt-get remove thunderbird* libreoffice*

# setup ssh
# sudo apt-get install ethtool
systemctl enable ssh
sudo ufw allow ssh

echo "install docker"
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

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
for file in "bash" "redshift" "xresources" "kitty"; do
  stow --verbose --target="$HOME" --dir="devserver" --restow "$file"
done

# stow common files
for file in "vim" "nvim" "tmux"; do
  stow --verbose --target="$HOME" --dir="common" --restow "$file"
done

# nvim required dep for some features
python3 -m pip install --user --upgrade pynvim

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

# add backgrounds to pixmaps
sudo stow --verbose --target="/" --dir="devserver" --restow "backgrounds"

echo "* install flatpak *"
sudo apt-get install -y flatpak gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak list
# flatpak install gwe blender mypaint io.qt.QtCreator
# install visual studio code via Snap

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

# disable annoying bell
# sudo su root
# echo "set bell-style none" >> /etc/inputrc

# add on client machine for jupynotebooks
# ssh -N -f -L 8888:localhost:9000 $USER@$HOSTNAME

# change grub at /etc/default/grub
# GRUB_TIMEOUT_STYLE=menu
# GRUB_TIMEOUT=40
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
change grub timeout \n\
set cpupower for kernal \n\
install flatpak packages (refer above) \n\
run as root for /etc/inputrc file \n\
check all symlinked files \n\
dotfiles test sync \n\
perform reboot \n\
\n\
login to literally everything \n\
attach; any other dotfiles from your repo/re-login \n\
"
