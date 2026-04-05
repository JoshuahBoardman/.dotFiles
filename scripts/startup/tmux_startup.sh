#!/bin/bash

# Your default sessions
default_sessions=("dev" "test" "server" "agents" "notes" "dotFiles")
default_session_dirs=("$HOME" "$HOME" "$HOME" "$HOME" "$HOME/life_management/" "$HOME/.dotFiles")

# Kill all sessions not in the default list
for s in $(tmux list-sessions -F "#{session_name}"); do
    if [[ ! " ${default_sessions[@]} " =~ " ${s} " ]]; then
        tmux kill-session -t "$s"
    fi
done

# Create default sessions if they don't exist
for i in "${!default_sessions[@]}"; do
    tmux has-session -t "${default_sessions[$i]}" 2>/dev/null || tmux new-session -d -s "${default_sessions[$i]}" -c "${default_session_dirs[$i]}"
done

# Attach to the first default session
tmux attach-session -t "dev"

