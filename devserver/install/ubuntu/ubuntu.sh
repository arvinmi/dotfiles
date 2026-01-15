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

# move to root of dotfiles dir
cd $HOME/dotfiles/

# Ask for the administrator password upfront (undo if necessary)
sudo -v

echo "* install/remove packages *"
# install packages (apt-mark showmanual)
sudo apt-get update && sudo apt-get upgrade -y
sudo apt install -y build-essential htop fzf git golang rclone iptables ncdu \
fastfetch fail2ban ranger tree tmux glances kitty gimp vim curl \
adwaita-icon-theme-full vorta plocate net-tools gnome-tweaks xterm \
openssh-server python3-pip python3-venv nodejs npm logisim trash-cli gdb clang \
llvm valgrind btop stow mosh nvtop git-lfs yt-dlp bat imwheel
# remove stock software 
sudo apt-get remove thunderbird* libreoffice*
# install anydesk at https://deb.anydesk.com/howto.html
# install qemu-guest-agent if on proxmox
# sudo apt-get install -y qemu-guest-agent
# install delta for git diff at https://dandavison.github.io/delta/installation.html

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
sudo usermod -aG docker $USER

echo "install tailscale"
# curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/noble.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
# curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/noble.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list
# sudo apt-get update
# sudo apt-get install tailscale
# sudo tailscale up --advertise-exit-node

echo "install miniconda"
# cd Downloads
# wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
# bash ~/miniconda.sh
# conda config --add channels conda-forge
# conda config --set channel_priority strict
# conda create -n base2 python notebook jupyterlab

echo "install skypilot from source"
# conda create -y -n sky python=3.9
# git clone https://github.com/skypilot-org/skypilot.git
# cd skypilot
# pip install ".[all]"

echo "install sdkman"
# curl -s "https://get.sdkman.io" | bash
# sdk version

echo "install node"
# check at https://nodejs.org/en/download

echo "install agents"
# npm -g install @openai/codex @anthropic-ai/claude-code @google/gemini-cli \
# @sourcegraph/amp ccundo ccusage @ccusage/codex opencode-ai uniprof jscpd

echo "install bun"
# curl -fsSL https://bun.sh/install | bash

echo "install uv"
curl -LsSf https://astral.sh/uv/install.sh | sh

echo "install tpm"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "install nvidia-cuda-toolkit"
# https://developer.nvidia.com/cuda-downloads

echo "install cuDNN"
# https://developer.nvidia.com/cudnn

echo "install isaac-sim and isaac-lab"
# cd ~/code/build && git clone https://github.com/KyleM73/isaac_manager/tree/main iman
# cd iman && make conda
# conda activate ilab

# stow devserver files
rm -rf ~/.bashrc ~/.gitconfig

for file in "bash" "redshift" "xresources" "kitty" "conda" "git" "imwheel"; do
  stow --verbose --target="$HOME" --dir="devserver" --restow "$file"
done

# stow common files
for file in "vim" "nvim" "tmux"; do
  stow --verbose --target="$HOME" --dir="common" --restow "$file"
done

# setup nvim
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install neovim
# nvim required dep for some features
python3 -m pip install --user --upgrade pynvim
# nvim install autoformatters
# install "stylua", "black", "clang-format", "prettier"

# tmux source file
tmux source-file ~/.tmux.conf

# setup kvm
# echo "* install qemu/kvm packages *"
# sudo apt-get install -y virt-manager

# disable autosuspend for usb devices
sudo modprobe usbcore autosuspend=-1

# increase jigahertz 
# sudo apt-get install linux-tools-5.15.0-41-generic (change to latest)
# sudo cpupower frequency-set -g performance

# set nvidia-smi pl
# sudo cp "$HOME/dotfiles/devserver/sys/etc/systemd/system/nvidia-powerlimit.service" /etc/systemd/system/
# sudo systemctl daemon-reload
# sudo systemctl enable nvidia-powerlimit.service
# sudo systemctl start nvidia-powerlimit.service

# add backgrounds to pixmaps
sudo stow --verbose --target="/" --dir="devserver" --restow "backgrounds"

echo "* install flatpak *"
sudo apt-get install -y flatpak gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak list
# flatpak install gwe io.qt.QtCreator mypaint flathub org.blender.Blender

echo "* install visual-studio-code snap *"
# sudo snap install --classic code

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
Match Address ipv4/24_ADDR
  AllowUsers USER
  PasswordAuthentication no
Match Address ipv6/48_ADDR
  AllowUsers USER
  PasswordAuthentication no
EOF'

sudo systemctl reload ssh.service
exit

############################# UFW Configuration ###############################

sudo ufw --force reset
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw default deny routed

# tailscale
sudo ufw allow in on tailscale0
sudo ufw allow out on tailscale0

# forward rules
sudo ufw route allow in on tailscale0 out on enp6s18
sudo ufw route allow in on enp6s18 out on tailscale0

sudo ufw logging on
sudo ufw logging low
sudo ufw --force enable
sudo ufw reload
sudo ufw status verbose

################################# Post Setup ##################################

# set mouse scrolling speed (imwheel)
systemctl --user daemon-reload
systemctl --user enable --now imwheel.service

# for proxmox, configure '/etc/gdm3/custom.conf'
# set 'WaylandEnable=false', 'AutomaticLoginEnable = true', 'AutomaticLogin = USER'

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
# GRUB_TIMEOUT=5
# GRUB_CMDLINE_LINUX_DEFAULT="quiet splash nvidia-drm.modeset=1 nvidia.NVreg_PreserveeVideoMemoryAllocations=1 tsc=reliable"
# sudo update-grub

# stop update to new LTS version prompt
# sudo sed -i 's/lts$/never/g' /etc/update-manager/release-upgrades

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
PROXMOX: sudo apt install lm-sensors \n\
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
