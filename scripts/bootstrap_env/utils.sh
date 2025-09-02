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
	local flags=$2
	local arguments=$3
	
	echo "$program $flags $arguments"
}

