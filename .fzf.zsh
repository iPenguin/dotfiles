# Setup fzf
# ---------
if [[ ! "$PATH" == */home/bmilco/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/bmilco/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/bmilco/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/bmilco/.fzf/shell/key-bindings.zsh"
