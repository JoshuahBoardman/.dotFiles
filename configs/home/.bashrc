#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Enter vi mode
set -o vi

# Start starship
sleep 0.05 # Provides time for starship to get calculate width
eval "$(starship init bash)"

# Adds NVM (Node Version Manager) to path 
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm


#NOTE: Swapped to tmux from zellij
#if command -v zellij >/dev/null 2>&1; then
    # Only launch zellij if not already inside it
#    if [ -z "$ZELLIJ" ] && [ -n "$PS1" ]; then
#        exec zellij
#    fi
#fi

#NOTE: Auto attach to dev tmux session
if command -v tmux >/dev/null 2>&1 && [ -z "$TMUX" ] && [ -n "$PS1" ]; then
    ~/.local/bin/tmux_startup.sh
fi


