#!/bin/bash

# Cross (✗) and Tick (✔) icons using Nerd Fonts
cross_icon=$'\u2717'
tick_icon=$'\u2714'

# Colors
red='\033[0;31m'
green='\033[0;32m'
reset='\033[0m'

# Function to load variables from a file
load_variables_from_file() {
	local file_path="$1"
	if [ -f "$file_path" ]; then
		echo -e "(${green}${tick_icon}${reset}) Loading variables from $file_path"
		source "$file_path"
	else
		echo -e "(${red}${cross_icon}${reset}) $file_path not found."
	fi
}

set -a

load_variables_from_file "devops/config.env"
load_variables_from_file "config.env"

set +a
