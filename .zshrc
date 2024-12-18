# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="$PATH:$HOME/.local/bin:/usr/local/go/bin"
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"


#export PYENV_ROOT="$HOME/.pyenv"
#command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init -)"

HIST_STAMPS="yyyy-mm-dd"
ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_TMUX_AUTOSTART='false'

plugins=(ansible \
    aws \
    docker \
    docker-compose \
    fzf \
    git \
    helm \
    kubectl \
    pip \
    pyenv \
    python \
    ssh-agent \
    tmux \
    zsh-autosuggestions \
    zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration
setopt correct

# You may need to manually set your language environment
export LANG=en_US.UTF-8

alias dots='git --git-dir=$HOME/.dots.git/ --work-tree=$HOME'
alias ls='eza'
alias os='openstack'
alias badpods1="kubectl get po -A -o wide | grep -Pv '(?:[^\s]+\s+){2}(?:([0-9]+)\/\1|[^\s]+\s+Completed)'"
alias badpods="watch \"kubectl get po -A -o wide | grep -Pv '(?:[^\s]+\s+){2}(?:([0-9]+)\/\1|[^\s]+\s+Completed)'\""
alias ip="ip --color=always"
alias killvpn="sudo kill -9 \$(ps -aux | grep openconnect | grep fortinet | awk '{ print \$2 }')"

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

# fuzzy find
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/home/bmilco/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
