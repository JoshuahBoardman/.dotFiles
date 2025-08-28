#!/bin/bash

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

package_keys=("go" "fd" "git" "gcc" "make" "ripgrep" "nodejs" "unzip" "neovim" "test")

declare -A packages

packages["go.value"]="go"
packages["go.manager"]="pacman"

packages["fd.value"]="fd"
packages["fd.manager"]="pacman"

packages["git.value"]="git"
packages["git.manager"]="pacman"

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

