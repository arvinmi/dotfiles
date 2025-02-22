#!/usr/bin/env bash

######################### * Installation Instructions * ########################

# * TODO: (initial install, please consult help file)
# git config --global credential.helper store
# git config --global color.ui true
# git config --global push.default simple
# git config --global user.name "arvinmi"
# git config --global user.email "YOUR_EMAIL"
# git clone https://github.com/arvinmi/dotfiles.git
# cd dotfiles/server/install/osu
# chmod +x centos0.sh
# sh centos0.sh

# * TODO: (rebuild)
# cd dotfiles/server/install/osu
# sh centos0.sh

############################## System Configuration #############################

echo "Hello $(whoami)! Let's get you set up."

# move to root of dotfiles dir
cd $HOME/dotfiles/

# Ask for the administrator password upfront (undo if necessary)
# sudo -v

echo "* install/remove packages *"
# install packages (module --help)
module load python3/3.10 anaconda/2023.03 cuda/12.2 gcc/12.2 llvm-clang/14.0.0
# install extra packages
# module load rust/1.47

echo "configure anaconda"
# conda config --add channels conda-forge
# conda config --set channel_priority strict
# conda create -n testing python notebook jupyterlab htop tmux fzf ncdu tree ranger-fm

# echo "install skypilot from source"
# conda create -y -n sky python=3.9
# git clone https://github.com/skypilot-org/skypilot.git
# cd skypilot
# pip install ".[all]"

echo "install sdkman"
# curl -s "https://get.sdkman.io" | bash
# sdk version

echo "install tpm"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# stow common files
for file in "vim" "nvim" "tmux"; do
  stow --verbose --target="$HOME" --dir="common" --restow "$file"
done

# stow server files
for file in "bashrc" "conda" "scripts"; do
  stow --verbose --target="$HOME" --dir="server" --restow "$file"
done

# tmux source file
tmux source-file ~/.tmux.conf

################################# Post Setup ##################################

# add on client machine for jupynotebooks
# ssh -N -f -L 8888:localhost:9000 $USER@$HOSTNAME

# create swapfile
# echo "swapfile"
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
check all symlinked files \n\
dotfiles test sync \n\
add swapfile, if needed \n\
perform reboot \n\
\n\
login to literally everything \n\
attach; any other dotfiles from your repo/re-login \n\
"
