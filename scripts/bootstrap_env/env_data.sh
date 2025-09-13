#!/bin/bash

# NOTE: Some point it might be a good idea to swap over to using JSON...

#########################################################
#'a This script is used for system/enviorment config data #
#########################################################

##########################
#### Config Structure ####
##########################

config_keys=("sym_link_manager")

declare -A config 

config["sym_link_manager.value"]="stow"
config["sym_link_manager.parameters"]="-Rvt destination_dir -d source_dir"
stow -Rvt ~ -d ~/.dotFiles/configs home

##########################
#### Package Managers ####
##########################

# TODO: Add yay back (need a yay install method first)
#TODO: Setup flatpak
manager_keys=("pacman")

declare -A managers

managers["pacman.value"]="pacman"
managers["pacman.install_flags"]="-S --noconfirm --needed"

managers["yay.value"]="yay"
managers["yay.install_flags"]=""

# TODO: need to do setup for flatpak
managers["flatpak.value"]="flatpak"
managers["flatpak.install_flags"]="flatpak install flathub "

##################
#### Packages ####
##################

#TODO: Add property to store package config location
package_keys=("git" "stow" "go" "fd" "gcc" "make" "ripgrep" "nodejs" "unzip" "neovim" "networkmanager" "intel-ucode" "mesa" "vulkan-intel" "lib32-mesa" "base-devel" "git" "wayland" "hyprland" "uwsm" "ghostty" "firefox" "pipewire" "wireplumber" "ttf-dejavu" "waybar" "hyprpaper" "hyprshot" "swaync" "hyprlock" "starship" "ly" "fastfetch" "obs-studio" "gimp" "yay" "ffmpeg" "man-pages" "man-db" "tldr" "timew" "btop" "nnn" "aichat" "cheat" "github-cli" "fzf" "tmux" "discord" "spotify" "dotnet-runtime" "dotnet-sdk" "aspnet-runtime")

declare -A packages

# TODO: Set install levels for each package, should only install what is needed for the system
# - Some of these are not needed in a WSL enviorment for example
# - Make the levels hgih, medium, and low, with high being the use everywhere type packages and low being packages only for a fresh arch setup.

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

#packages["networkmanager.value"]="networkmanager"
#packages["networkmanager.manager"]="pacman"

#packages["intel-ucode.value"]="intel-ucode" 
#packages["intel-ucode.manager"]="pacman"

#packages["mesa.value"]="mesa" 
#packages["mesa.manager"]="pacman"

#packages["vulkan-intel.value"]="vulkan-intel" 
#packages["vulkan-intel.manager"]="pacman"


#TODO: Setup multi lib for pacman in package_management.sh
#packages["lib32-mesa.value"]="lib32-mesa" 
#packages["lib32-mesa.manager"]="pacman"

#packages["lib32-vulkan-intel.value"]="lib32-vulkan-intel" 
#packages["lib32-vulkan-intel.manager"]="pacman"

packages["base-devel.value"]="base-devel" 
packages["base-devel.manager"]="pacman"

packages["git.value"]="git" 
packages["git.manager"]="pacman"

# TODO: Yay either must be installed via aur or you need to build it from the github repo
#packages["yay.value"]="yay"  
#packages["yay.manager"]="pacman"

#packages["wayland.value"]="wayland" 
#packages["wayland.manager"]="pacman"

#packages["hyprland.value"]="hyprland" 
#packages["hyprland.manager"]="pacman"

##packages["uwsm.value"]="uwsm" 
#packages["uwsm.manager"]="pacman"

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

#packages["wofi.value"]="wofi" 
#packages["wofi.manager"]="pacman"

#packages["waybar.value"]="waybar" 
#packages["waybar.manager"]="pacman"

#packages["hyprpaper.value"]="hyprpaper" 
#packages["hyprpaper.manager"]="pacman"

packages["neovim.value"]="neovim" 
packages["neovim.manager"]="pacman"

#packages["hyprshot.value"]="hyprshot" 
#packages["hyprshot.manager"]="pacman"

#packages["swaync.value"]="swaync" 
#packages["swaync.manager"]="pacman"

#packages["hyprlock.value"]="hyprlock" 
#packages["hyprlock.manager"]="pacman"

# NOTE: Currently I have swaped back to tmux instead
#packages["zellij.value"]="zellij" 
#packages["zellij.manager"]="pacman"

#TODO: find a way to source tmux config/plugin stuff on install
packages["tmux.value"]="tmux" 
packages["tmux.manager"]="pacman"

packages["starship.value"]="starship" 
packages["starship.manager"]="pacman"

#packages["ly.value"]="ly" 
#packages["ly.manager"]="pacman"

packages["fastfetch.value"]="fastfetch" 
packages["fastfetch.manager"]="pacman"

packages["obs-studio.value"]="obs-studio" 
packages["obs-studio.manager"]="pacman"

packages["gimp.value"]="gimp" 
packages["gimp.manager"]="pacman"

packages["ffmpeg.value"]="ffmpeg" 
packages["ffmpeg.manager"]="pacman"

packages["man-pages.value"]="man-pages" 
packages["man-pages.manager"]="pacman"

packages["man-db.value"]="man-db" 
packages["man-db.manager"]="pacman"

packages["tldr.value"]="tldr" 
packages["tldr.manager"]="pacman"

packages["timew.value"]="timew" 
packages["timew.manager"]="pacman"

packages["btop.value"]="btop" 
packages["btop.manager"]="pacman"

packages["nnn.value"]="nnn" 
packages["nnn.manager"]="pacman"

packages["aichat.value"]="aichat" 
packages["aichat.manager"]="pacman"

packages["cheat.value"]="cheat" 
packages["cheat.manager"]="yay"

packages["github-cli.value"]="github-cli" 
packages["github-cli.manager"]="pacman"

packages["fzf.value"]="fzf" 
packages["fzf.manager"]="pacman"

packages["flatpak.value"]="flatpak" 
packages["flatpak.manager"]="pacman"

#TODO: Need to do work on flatpak
#packages["discord.value"]="com.discordapp.Discord" 
#packages["discord.manager"]="flatpak"

packages["spotify.value"]="spotify" # Could use the spotify_launcher from pacman, but I want to update the app with pacman instead of having auto spotify updates
packages["spotify.manager"]="yay"

packages["dotnet-runtime.value"]="dotnet-runtime" 
packages["dotnet-runtime.manager"]="pacman"

packages["dotnet-sdk.value"]="dotnet-sdk" 
packages["dotnet-sdk.manager"]="pacman"

packages["aspnet-runtime.value"]="aspnet-runtime" 
packages["aspnet-runtime.manager"]="pacman"

###################
#### Git Repos ####
###################

repo_keys=("pacman")

declare -A repos 

#TODO: Add all needed properties to manage and setup a repo
repos["tpm.value"]="tpm" 
repos["tpm.source"]="git@github.com:tmux-plugins/tpm.git"

