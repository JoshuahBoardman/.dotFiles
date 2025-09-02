#!/bin/bash

source ./utils.sh
source ./config_data.sh

link_config() {
	local destination_dir="$1" 
	local source_dir="$2"

	local symlinker=$(get_property config "sym_link_manager" "value")
	local flags=$(get_property config "sym_link_manager" "flags")
	local arguments="$destination_dir $source_dir"

	if ! is_installed "$symlinker"; then
    	    continue
    	fi

	local link_command=$(build_command "$symlinker" "$flags" "$arguments")

	#TODO: swap to eval once finished.
	echo "$link_command"
