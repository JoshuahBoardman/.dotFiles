#!/bin/bash

source ./utils.sh
source ./env_data.sh

#TODO: Create a function that will look through env_data for config_paths and then delete any configs 
#	that already exist which then can be replaced with stow

link_config() {
    	local destination_dir="$1"
    	local source_dir="$2"

	local symlinker=$(get_property config "sym_link_manager" "value")
	local parameters=$(get_property config "sym_link_manager" "parameters")

    	if ! is_installed "$symlinker"; then
       		echo "$symlinker not installed - please install $symlinker in order to link configs"
        	return 1
    	fi

    	parameters=$(value_substitution "$parameters" "destination_dir" "$destination_dir")
    	parameters=$(value_substitution "$parameters" "source_dir" "$source_dir")

    	local link_command
    	link_command=$(build_command "$symlinker" "$parameters")

    	echo "sudo $link_command"
    	eval "sudo $link_command"
}
