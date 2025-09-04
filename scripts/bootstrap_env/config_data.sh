#!/bin/bash
#########################################################
#'a This script is used for system/enviorment config data #
#########################################################

##########################
#### Config Structure ####
##########################

config_keys=("sym_link_manager")

declare -A config 

config["sym_link_manager.value"]="stow"
config["sym_link_manager.flags"]="-Rvt"


##########################
#### Package Managers ####
##########################

manager_keys=("pacman" "yay")

declare -A managers

managers["pacman.value"]="pacman"
managers["pacman.install_flags"]="-S --noconfirm --needed"

managers["yay.value"]="yay"
managers["yay.install_flags"]=""

##################
#### Packages ####
##################

#TODO: Add property to store package config location
package_keys=("git" "stow" "go" "fd" "gcc" "make" "ripgrep" "nodejs" "unzip" "neovim" "test" "networkmanager" "intel-ucode" "mesa" "vulkan-intel" "lib32-mesa" "base-devel" "git" "yay" "wayland" "hyprland" "uwsm" "ghostty" "firefox" "pipewire" "wireplumber" "ttf-dejavu" "waybar" "hyprpaper" "neovim" "hyprshot" "swaync" "hyprlock" "zellij" "stow" "starship" "ly" "fastfetch" "obs-studio" "gimp")

declare -A packages

packages["git.value"]="git"
packages["git.manager"]="pacman"

packages["stow.value"]="stow"
packages["stow.manager"]="pacman"

packages["go.value"]="go"
packages["go.manager"]="pacman"

packages["fd.value"]="fd"
packages["fd.manager"]="pacman"

packages["gcc.value"]="gcc"
packages["gcc.manager"]="pacman"

packages["make.value"]="make"
packages["make.manager"]="pacman"

packages["ripgrep.value"]="ripgrep"
packages["ripgrep.manager"]="pacman"

packages["nodejs.value"]="nodejs"
packages["nodejs.manager"]="pacman"

packages["unzip.value"]="unzip"
packages["unzip.manager"]="pacman"

packages["neovim.value"]="neovim"
packages["neovim.manager"]="pacman"

packages["networkmanager.value"]="networkmanager"
packages["networkmanager.manager"]="pacman"

packages["intel-ucode.value"]="intel-ucode" 
packages["intel-ucode.manager"]="pacman"

packages["mesa.value"]="mesa" 
packages["mesa.manager"]="pacman"

packages["vulkan-intel.value"]="vulkan-intel" 
packages["vulkan-intel.manager"]="pacman"

packages["lib32-mesa.value"]="lib32-mesa" 
packages["lib32-mesa.manager"]="pacman"

packages["lib32-vulkan-intel.value"]="lib32-vulkan-intel" 
packages["lib32-vulkan-intel.manager"]="pacman"

packages["base-devel.value"]="base-devel" 
packages["base-devel.manager"]="pacman"

packages["git.value"]="git" 
packages["git.manager"]="pacman"

packages["yay.value"]="yay" 
packages["yay.manager"]="pacman"

packages["wayland.value"]="wayland" 
packages["wayland.manager"]="pacman"

packages["hyprland.value"]="hyprland" 
packages["hyprland.manager"]="pacman"

packages["uwsm.value"]="uwsm" 
packages["uwsm.manager"]="pacman"

packages["ghostty.value"]="ghostty" 
packages["ghostty.manager"]="pacman"

packages["firefox.value"]="firefox" 
packages["firefox.manager"]="pacman"

packages["pipewire.value"]="pipewire" 
packages["pipewire.manager"]="pacman"

packages["wireplumber.value"]="wireplumber" 
packages["wireplumber.manager"]="pacman"

packages["ttf-dejavu.value"]="ttf-dejavu" 
packages["ttf-dejavu.manager"]="pacman"

packages["wofi.value"]="wofi" 
packages["wofi.manager"]="pacman"

packages["waybar.value"]="waybar" 
packages["waybar.manager"]="pacman"

packages["hyprpaper.value"]="hyprpaper" 
packages["hyprpaper.manager"]="pacman"

packages["neovim.value"]="neovim" 
packages["neovim.manager"]="pacman"

packages["hyprshot.value"]="hyprshot" 
packages["hyprshot.wanager"]="pacman"

packages["swaync.value"]="swaync" 
packages["swaync.wanager"]="pacman"

packages["hyprlock.value"]="hyprlock" 
packages["hyprlock.wanager"]="pacman"

packages["zellij.value"]="zellij" 
packages["zellij.wanager"]="pacman"

packages["stow.value"]="stow" 
packages["stow.wanager"]="pacman"

packages["starship.value"]="starship" 
packages["starship.wanager"]="pacman"

packages["ly.value"]="ly" 
packages["ly.wanager"]="pacman"

packages["fastfetch.value"]="fastfetch" 
packages["fastfetch.wanager"]="pacman"

packages["obs-studio.value"]="obs-studio" 
packages["obs-studio.wanager"]="pacman"

packages["gimp.value"]="gimp" 
packages["gimp.wanager"]="pacman"

packages["gimp.value"]="gimp" 
packages["gimp.wanager"]="pacman"




packages["test.value"]="test" #TODO:Remove this set
packages["test.manager"]="testy"
