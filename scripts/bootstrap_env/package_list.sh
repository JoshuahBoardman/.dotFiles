#!/bin/bash

#TODO: Rename this file to something like "config_data.sh".
# - Update all aditional files, that reference this file.

##########################
#### Package Managers ####
##########################

manager_keys=("pacman" "yay")

declare -A managers

managers["pacman.value"]="pacman"
managers["pacman.install_flags"]="-S --noconfirm --needed"

managers["yay.value"]="yay"
managers["yay.install_flags"]=""

#################
#### Package ####
#################

#TODO: Add property to store package config location
package_keys=("git" "stow" "go" "fd" "gcc" "make" "ripgrep" "nodejs" "unzip" "neovim" "test")

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

packages["test.value"]="test"
packages["test.manager"]="testy"

