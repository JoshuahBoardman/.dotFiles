#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

#if uwsm check may-start; then
#	exec uwsm start hyprland-uwsm.desktop
#fi

if [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
  exec Hyprland
fi

