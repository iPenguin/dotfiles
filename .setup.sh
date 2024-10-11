#!/usr/bin/env bash
#
# Installing software for use with the dot files in this repo

set -eou pipefail

font_name="FiraCode"
go_version="1.22.1"
delta_version="0.17.0"

echo "Install applicatoins"
sudo apt install -y \
  bat \
  cmake \
  eza \
  figlet \
  npm \
  vim \
  zsh
sudo usermod -s /usr/bin/zsh $USER

if [ ! -d $HOME/.fzf ]
then 
  echo "--==[[ Install Fuzzy Finder ]]==--"
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --bin --no-update-rc
fi

if [ ! -d $HOME/.pyenv ]
then
  echo "--==[[ Install pyenv ]]==--"
  git clone https://github.com/pyenv/pyenv.git ~/.pyenv
fi

if [ ! -f $HOME/.local/bin/delta ]
then
  echo "--==[[ Install Delta ]]==--"
  delta_pkg="delta-${delta_version}-x86_64-unknown-linux-gnu"
  curl -L -o /tmp/${delta_pkg}.tar.gz \
    https://github.com/dandavison/delta/releases/download/${delta_version}/${delta_pkg}.tar.gz
  cd /tmp
  /usr/bin/tar -zxf /tmp/${delta_pkg}.tar.gz
  chmod +x /tmp/${delta_pkg}/delta
  mv /tmp/${delta_pkg}/delta ~/.local/bin/
  cd -
fi

if [ ! -d /usr/local/go ]
then
  echo "--==[[ Installing Golang ]]==--"
  curl https://dl.google.com/go/go${go_version}.linux-amd64.tar.gz \
    -o $HOME/.cache/go${go_version}.linux-amd64.tar.gz
  sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf $HOME/.cache/go${go_version}.linux-amd64.tar.gz
fi

if [ ! -d $HOME/.oh-my-zsh ]
then 
  echo "--==[[ Install oh-my-zsh ]]==--"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended --keep-zshrc"

  echo "--==[[ Install oh-my-zsh plugins ]]==--"
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi 

nerd_font="${font_name}NerdFontMono-Regular.ttf"
if [ ! -d "$HOME/.fonts/${nerd_font}" ]
then
  echo "--==[[ Install nerd fonts ]]==--"
  mkdir -p $HOME/.fonts
  #https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts
  curl \
    https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/${font_name}/Regular/${nerd_font} \
    -o $HOME/.fonts/${nerd_font}
fi

if [ ! -d $HOME/.oh-my-zsh/custom/themes/powerlevel10k ]
then
  echo "--==[[ Install Powerlevel 10k ]]==--"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

if [ ! -d $HOME/.vim/bundle/Vundle.vim ]
then
  echo "--==[[ Install Vundle ]]==--"
  mkdir -p ~/.vim/bundle
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

echo "--==[[ Install vim plugins ]]==--"
vim -c PluginInstall -c qall

if [ -d $HOME/.vim/bundle/YouCompleteMe ]
then
  echo "--==[[ Compile YouCompleteMe ]]==--"
  cd ~/.vim/bundle/YouCompleteMe
  ./install.py --go-completer --ts-completer
fi
