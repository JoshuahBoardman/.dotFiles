# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set default editor
export EDITOR=nvim

# Set colorful PS1 if available
if [[ $TERM =~ xterm* || $TERM == rxvt* || $TERM == alacritty* ]]; then
  export PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] '
else
  export PS1='[\u@\h \W]\$ '
fi

# Enable history appending instead of overwriting
shopt -s histappend

# History settings
HISTSIZE=1000
HISTFILESIZE=2000

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Alias definitions.
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -la'
alias l='ls -CF'
alias grep='grep --color=auto'

# Enable bash completion if available
if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

# Manjaro-specific aliases
alias update='sudo pacman -Syu'
alias upgrade='sudo pacman -Syyu'

# Add custom user bin paths if they exist
if [ -d "$HOME/.local/bin" ]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/bin" ]; then
  export PATH="$HOME/bin:$PATH"
fi

# i3-specific customization
export TERMINAL=alacritty
export BROWSER=firefox
export GTK_THEME=Matcha-dark-azul

eval "$(starship init bash)"
