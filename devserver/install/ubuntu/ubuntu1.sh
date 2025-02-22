#!/usr/bin/env bash

######################### * Installation Instructions * ########################

# * TODO: (install for WM, please consult help file)
# git config --global credential.helper store
# git clone https://github.com/arvinmi/dotfiles.git dotfiles
# cd dotfiles/devserver/install/ubuntu
# chmod +x ubuntu1.sh
# sh ubuntu1.sh

# * TODO: (rebuild)
# cd dotfiles/devserver/install/ubuntu
# sh ubuntu1.sh

############################## System Configuration #############################

echo "Hello $(whoami)! Let's get you set up."

# Ask for the administrator password upfront (undo if necessary)
sudo -v

echo "* install/remove packages *"
# install packages (apt-mark showmanual)
sudo apt-get update && sudo apt-get upgrade -y
sudo apt install -y i3 ristretto xfce4-screenshooter nitrogen xcursor-themes xclip \
xautolock gedit pnmixer xfce4-notifyd xfce4-volumed curl redshift tmux xfce4-power-manager \
kitty glances htop neofetch fzf plocate xterm thunar trash-cli gdb
sudo apt-get remove dunst
# if neccessary
# sudo apt-get install -y timeshift docker.io
# remove stock software
# sudo apt-get remove 

echo "* if needed, install lightdm"
# sudo apt-get install -y lightdm
# sudo systemctl enable lightdm.service
# sudo reboot

echo "* install x"
# sudo apt-get install xinit

echo "install tpm"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "install miniconda"
# cd Downloads
# wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.12.0-Linux-x86_64.sh
# chmod +x Miniconda3-py39_4.12.0-Linux-x86_64.sh
# bash ./Miniconda3-py39_4.12.0-Linux-x86_64.sh
# conda config --add channels conda-forge
# conda config --set channel_priority strict

# setup ssh
# sudo apt-get install -y openssh-server
# systemctl enable ssh
# sudo ufw allow ssh

# stow devserver files
for file in "bash" "i3" "redshift" "kitty"; do
  stow --verbose --target="$HOME" --dir="devserver" --restow "$file"
done

# stow common files
for file in "vim" "nvim" "tmux"; do
  stow --verbose --target="$HOME" --dir="common" --restow "$file"
done

# stow sys files (polkit, mouse acceleration, picom, i3status)
sudo stow --verbose --target="/" --dir="devserver" --restow "sys"

# confiure redshift config
# can cp if not working
redshift -c ~/.config/redshift.conf

# tmux source file
tmux source-file ~/.tmux.conf

# nvim install autoformatters
# install "stylua", "black", "clang-format", "prettier"

############################# SSH Configuration ###############################

<<comment
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
comment

################################# Post Setup ##################################

# set up firewall
# sudo systemctl enable ufw
# sudo ufw enable

# disable annoying bell
# sudo su root
# echo "set bell-style none" >> /etc/inputrc

# add on client machine for jupynotebooks
# ssh -N -f -L 8888:localhost:9000 $USER@$HOSTNAME

# add backgrounds to pixmaps
sudo stow --verbose --target="/" --dir="devserver" --restow "backgrounds"

# change grub at /etc/default/grub
# GRUB_TIMEOUT_STYLE=menu
# GRUB_TIMEOUT=5
# sudo update-grub

# set nvidia-smi pl
# git clone https://github.com/arvinmi/devops-resources.git
# sudo cp "${HOME}/devops-resources/devserver/sys/nvidia-tdp.service" "/etc/systemd/system/"
# sudo cp "${HOME}/devops-resources/devserver/sys/nvidia-tdp.timer" "/etc/systemd/system/" 
# nvidia-smi -pm 1
# sudo systemctl daemon-reload
# sudo systemctl enable --now nvidia-tdp.timer

echo "           /(| "
echo "          (  : "
echo "         __\  \  _____ "
echo "       (____)  \| "
echo "      (____)|   | "
echo "       (____).__| "
echo "        (___)__.|_____ "

echo " "
echo "Done. Note that some of these changes require a logout/restart to take effect."

printf "TODO:\n\
configure: \n\
setup nvidia settings for no screen-tearing \n\
install miniconda \n\
change grub timeout \n\
check all symlinked files \n\
run as root for /etc/inputrc file  (if not already done) \n\
set up firewall (if needed) \n\
disable annoying bell \n\
consult help.md for instructions \n\
look above to install lightdm (if neccessary) \n\
\n\
login to literally everything \n\
attach; any other dotfiles from your repo/re-login \n\
"
