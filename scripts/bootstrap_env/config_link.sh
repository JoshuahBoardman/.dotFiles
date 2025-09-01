#!/bin/bash

source ./utils.sh
source ./config_data.sh

link_config() {
	local destination_dir="$1" 
	local source_dir="$2"

	# TODO: Refactor this to use anything with a specific key
	# - This would mean that I would need to pull the specific command needed to replace sotwscommand.
	if ! is_installed "stow"; then
    	    continue
    	fi

	#TODO: swap to eval once finished.
	echo "stow -Rvt $destination_dir $source_dir"
}

