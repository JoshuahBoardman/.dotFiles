#!/bin/bash

source ./package_management.sh
source ./config_link.sh

install_packages

# Sym link home configs using stow
# Sym link system configs with stow, will need additional flags
local destination_dir="~"
local sourc_dir="../../configs/home/"

link_config "~" "../../configs/home/" # symlink home config
link_config "/" "../../configs/system/" # symlink system config 
