#!/bin/bash

source ./package_management.sh
source ./config_link.sh

#TODO: handle arguments for what level of install we want along with specifing if we only want a fraction of the script to run

install_packages

# Sym link home configs using stow
# MAYBE: Might want to move these values into env_data.sh
home_destination_dir="~"
home_sourc_dir="~/.dotFiles/configs/"
home_package="home"

# Sym link system configs with stow, will need additional flags
system_destination_dir="/"
system_sourc_dir="~/.dotFiles/configs/system"
system_package="system"

link_config "$home_destination_dir" "$home_sourc_dir $home_package" # symlink home config
# link_config "$system_destination_dir" "$system_sourc_dir $system_package" # symlink system config 
