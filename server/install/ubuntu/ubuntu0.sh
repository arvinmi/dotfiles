#!/usr/bin/env bash

######################### * Installation Instructions * ########################

# * TODO: (initial install, please consult help file)
# git config --global credential.helper store
# git clone https://github.com/arvinmi/dotfiles.git
# cd dotfiles/server/install/ubuntu
# chmod +x ubuntu0.sh
# sh ubuntu0.sh

# * TODO: (rebuild)
# cd dotfiles/server/install/ubuntu
# sh ubuntu0.sh

############################## System Configuration #############################

echo "Hello $(whoami)! Let's get you set up."

# move to root of dotfiles dir
cd $HOME/dotfiles/

# Ask for the administrator password upfront (undo if necessary)
sudo -v

echo "* install/remove packages *"
# install packages (apt-mark showmanual)
sudo apt-get update && sudo apt-get upgrade -y
sudo apt install -y build-essential htop fzf git golang pgcli llvm rclone iptables \
ncdu neofetch neovim fail2ban ranger tree tmux vim curl net-tools python3-pip \
trash-cli gdb nodejs npm stow
# if needed graphics
# sudo apt-get install -y lxqt-core sddm

echo "install zt"
# curl -s https://install.zerotier.com | sudo bash
# curl -s http://download.zerotier.com/contact%40zerotier.com.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/zerotier.com.gpg > /dev/null
# sudo zerotier-cli join $ID

echo "install miniconda"
# cd Downloads
# wget https://repo.anaconda.com/miniconda/Miniconda3-py310_22.11.1-1-Linux-x86_64.sh (x86)
# wget https://repo.anaconda.com/miniconda/Miniconda3-py310_22.11.1-1-Linux-aarch64.sh (arm64)
# chmod +x Miniconda3-py310_22.11.1-1-Linux-x86_64.sh
# bash ./Miniconda3-py310_22.11.1-1-Linux-x86_64.sh
# conda config --add channels conda-forge
# conda config --set channel_priority strict
# conda create -n base2 python notebook jupyterlab

echo "install skypilot from source"
# conda create -y -n sky python=3.9
# git clone https://github.com/skypilot-org/skypilot.git
# cd skypilot
# pip install ".[all]"

echo "install nvidia-cuda"
# wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin (check current version)
# sudo mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600
# wget https://developer.download.nvidia.com/compute/cuda/12.0.0/local_installers/cuda-repo-ubuntu2204-12-0-local_12.0.0-525.60.13-1_amd64.deb
# sudo dpkg -i cuda-repo-ubuntu2204-12-0-local_12.0.0-525.60.13-1_amd64.deb
# sudo cp /var/cuda-repo-ubuntu2204-12-0-local/cuda-*-keyring.gpg /usr/share/keyrings/
# sudo apt-get update
# sudo apt-get -y install cuda

echo "install cuDNN"
# wget https://developer.nvidia.com/compute/cudnn/secure/8.6.0/local_installers/11.8/cudnn-local-repo-ubuntu2204-8.6.0.163_1.0-1_amd64.deb (check current version)
# sudo dpkg -i cudnn-local-repo-{ubuntu2204-8.6.0.163_1.0-1_amd64.deb}
# sudo cp /var/cudnn-local-repo-ubuntu2204-8.6.0.163/cudnn-local-FAED14DD-keyring.gpg /usr/share/keyrings/
# sudo apt-get update
# sudo apt-get install libcudnn8
# sudo apt-get install libcudnn8-dev
# sudo apt-get install libcudnn8-samples

echo "install sdkman"
# curl -s "https://get.sdkman.io" | bash
# sdk version

echo "install tpm"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "configure aws cli"
# aws configure

echo "check aws cli"
# aws s3 cp text.txt s3://bucket-name
# aws ec2 describe-instances

echo "setup cron for server shutdown"
# sudo crontab -u root -e
# crontab -e
# chmod +x ~/dotfiles/server/scripts/cron_scripts/shutdown_if_inactive.sh

# stow common files
for file in "vim" "tmux"; do
  stow --verbose --target="$HOME" --dir="common" --restow "$file"
done

# stow server files
for file in "bash" "conda" "scripts"; do
  stow --verbose --target="$HOME" --dir="server" --restow "$file"
done

# tmux source file
tmux source-file ~/.tmux.conf

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

################################# fail2ban ####################################

echo "configure fail2ban"

sudo bash -c 'cat >> /etc/fail2ban/jail.local << EOF
[DEFAULT]
bantime = -1
findtime = 3600
maxretry = 5
EOF'

############################# SSH Configuration ###############################

echo "configure ssh config"

sudo bash -c 'cat >> /etc/ssh/sshd_config << EOF
# AllowTcpForwarding no (for third-party apps)
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

################################# Post Setup ##################################

# echo "* create standard USER password if not done (ctrl + d to exit)"
# create $USER {PASSWORD}
# sudo passwd $USER

# DO NOT SETUP, use aws firewall
# sudo systemctl enable ufw
# sudo ufw enable

# add on client machine for jupynotebooks
# ssh -N -f -L 8888:localhost:9000 $USER@$HOSTNAME

# change grub at /etc/default/grub
# GRUB_TIMEOUT_STYLE=menu
# GRUB_TIMEOUT=5
# sudo update-grub

# create swapfile
echo "swapfile"
# in this example dd command, the swap file is 4 GB (128 MB x 32)
# sudo dd if=/dev/zero of=/swapfile bs=128M count=32
# sudo chmod 600 /swapfile
# sudo mkswap /swapfile
# sudo swapon /swapfile
# sudo swapon -s
# sudo vi /etc/fstab
# add the following new line at the end of the file, save the file, and then exit
# /swapfile swap swap defaults 0 0

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
setup user + root cron jobs \n\
check aws cli \n\
add aws s3 endpoint for vpc (if needed) \n\
disable auto poweroff from user data on launch \n\
install miniconda \n\
install zt (if needed) \n\
change grub timeout to \n\
set cpupower for kernal \n\
if needed install flatpak packages (if needed) \n\
check all symlinked files \n\
dotfiles test sync \n\
add swapfile, if needed \n\
perform reboot \n\
\n\
login to literally everything \n\
attach; any other dotfiles from your repo/re-login \n\
"
