#!/bin/which sh
#
# Installing software for use with the dot files in this repo

# Fuzzy Finder
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Oh-my-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Powerline 10k

# Donwload a Nerd Font:
#https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts
curl
https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraCode/Regular/FiraCodeNerdFontMono-Regular.ttf \
  -o $HOME/.fonts/FiraCodeNerdFontMono-Regualar.ttf

# Download Powerline
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Vim Plugins
sudo apt install vim -y
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim -c PluginInstall -c qall
