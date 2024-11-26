#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

# i3
if type "xrandr" > /dev/null; then
      for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --reload mainbar -c ~/.config/polybar/config.ini &
      done
    else
    polybar --reload mainbar -c ~/.config/polybar/config.ini &
    fi


#if type "xrandr"; then
#  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
#    MONITOR=$m polybar --reload mainbar &
#  done
#else
#  polybar --reload mainbar &
#fi

    echo "Bars Launched..."
