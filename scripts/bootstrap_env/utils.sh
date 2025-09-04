#!/bin/bash

# NOTE: Used for accessing dotFiles config data.
get_property() {
	declare -n structure="$1"
	local name_space="$2"
	local property="$3"

	local key="$name_space.$property"
	echo "${structure["$key"]}"
}

is_installed() {
	local program=$1

	command -v "$program" >/dev/null 2>&1
}

build_command() {
	local program=$1
	shift
	local parameters=("$@")


	echo "$program ${parameters[@]}"
}

value_substitution() {
	local string="$1"
    	local placeholder="$2"
    	local substitution="$3"

    	local substituted_string=""

    	for word in $string; do
		if [ "$word" != "$placeholder" ]; then
		    	substituted_string+="$word "
		else
		    	substituted_string+="$substitution "
		fi
	done

	# Remove trailing space
	substituted_string="${substituted_string%" "}"

	echo "$substituted_string"
}


