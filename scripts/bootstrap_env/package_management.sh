#!/bin/bash

source ./utils.sh
source ./config_data.sh

_gather_manager_packages() {
	local manager=$1
	local packages_by_manager=()
	
	for key in "${package_keys[@]}"; do
	    local required_manager=$(get_property packages "$key" "manager")

	    if [ "$required_manager" = "$manager" ]; then
		packages_by_manager+=("$(get_property packages "$key" "value")")
	    fi
	done
	
	echo "${packages_by_manager[@]}"
}

install_packages() {
    for manager in "${manager_keys[@]}"; do

	local manager_value=$(get_property "managers" "$manager" "value")
	
	if ! is_installed "$manager_value"; then
    	    continue
    	fi

	local build_flags=$(get_property managers "$manager" "install_flags")
        local package_list=$(_gather_manager_packages "$manager")

        [ -z "$package_list" ] && continue  # skip if no packages

        local install_command=$(build_command "$manager" "$build_flags" "$package_list")

        echo "Running: $install_command"

	#TODO: Uncomment the eval line when ready to use
        # Execute the command and wait for it to finish
        #eval "$install_command"
        local exit_code=$?

        # Stop the script if the command failed
        if [ $exit_code -ne 0 ]; then
            echo "Error: $manager install command failed with exit code $exit_code"
            exit $exit_code
        fi
    done
}

install_packages 
