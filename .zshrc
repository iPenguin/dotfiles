# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="$PATH:$HOME/bin:$HOME/.local/bin:/usr/local/go/bin"
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

ZSH_THEME="powerlevel10k/powerlevel10k"

HIST_STAMPS="yyyy-mm-dd"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git aws docker docker-compose helm kubectl pip python pyenv \
  vagrant vagrant-prompt web-search ssh-agent zsh-syntax-highlighting \
  zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# fuzzy find
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# User configuration
setopt correct

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
alias ls=exa
alias dots='git --git-dir=$HOME/.dots.git/ --work-tree=$HOME'
alias os='openstack'

dothevenvstuff() {
    # If we're currently in a venv, deactivate before proceeding
    if [[ -n $VIRTUAL_ENV ]]; then
        deactivate
        [[ $ZSH_NAME == zsh ]] && rehash
    fi
    if [[ ! -d ./.venv ]]; then
        echo "Creating venv"
        python3 -m venv .venv
    fi
    . .venv/bin/activate && echo "Activated venv"

    # IMPROVE: Do we need this one, or just the one after?
    [[ $ZSH_NAME == zsh ]] && rehash
    # IMPROVE: Handle not having any requirements files
    local file
    for file in requirements*.txt; do
        echo "Install requirements file: $file"
        pip3 install -r "$file"
    done
    [[ $ZSH_NAME == zsh ]] && rehash
}

# Add multiple kube configs
KUBECONFIG="$HOME/.kube/config"
for config in $HOME/.kube/configs/*
do
    export KUBECONFIG="$config:$KUBECONFIG"
done

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/home/bmilco/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
