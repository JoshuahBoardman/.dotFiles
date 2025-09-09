#!/bin/bash

# Your default sessions
default_sessions=("dev" "test" "server" "output" "notes")

# Kill all sessions not in the default list
for s in $(tmux list-sessions -F "#{session_name}"); do
    if [[ ! " ${default_sessions[@]} " =~ " ${s} " ]]; then
        tmux kill-session -t "$s"
    fi
done

# Create default sessions if they don't exist
for s in "${default_sessions[@]}"; do
    tmux has-session -t "$s" 2>/dev/null || tmux new-session -d -s "$s"
done

#TODO: Open notes straight to my vault

# Attach to the first default session
tmux attach-session -t "dev"

