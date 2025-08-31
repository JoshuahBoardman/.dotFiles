#!/bin/bash

source ./utils.sh
source ./package_list.sh


# NOTE: For the time being this is fine, but potentially I should use an associative 
# array and have an array of keys that is used to access the items, using "nameSpace.value" 
# syntax to access specific values for additional context information.
#TODO: Make a manager struct and break packages into an associative array to specify manager: 
# some packages need to be installed from the AUR instead of from the standard repo, 
# so I will need to install yay via pacman, and then install the rest with yay.
# - Most of these functions will need rewritten with this new structure.
# TODO: Break packages and managers out into a seperate file that is source into this 
# functionality called packages and managers
# packages=("go" "fd" "git" "gcc" "make" "ripgrep" "nodejs" "unzip" "neovim")

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

_has_manager() {
	local manager=$1
	command -v "$1" >/dev/null 2>&1
}

_build_command() {
	local manager=$1
	local package_list=$2

	local build_flags=$(get_property managers "$manager" "install_flags")
	
	echo "$manager $build_flags $package_list"
}



install_packages() {
    for manager in "${manager_keys[@]}"; do
        local package_list=$(_gather_manager_packages "$manager")
        [ -z "$package_list" ] && continue  # skip if no packages

        local install_command=$(_build_command "$manager" "$package_list")

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
