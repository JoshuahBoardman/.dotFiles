#!/bin/bash

# NOTE: Used for accessing dotFiles config data.
get_property() {
	declare -n structure="$1"
	local name_space="$2"
	local property="$3"

	local key="$name_space.$property"
	echo "${structure["$key"]}"
}
