#!/bin/bash

# Define icons for messages
tick_icon="[✓]"
cross_icon="[✗]"
flag_icon="[⚑]"

# Define colors for messages
green="\e[32m"
yellow="\e[33m"
red="\e[31m"
reset="\e[0m"

if command -v uv &> /dev/null; then
    PIP_CMD="uv pip"
else
    PIP_CMD="pip"
fi

# Function to display a message with an icon and color
display_message() {
	local icon="$1"
	local color="$2"
	local message="$3"
	echo -e "${color}${icon} ${message}${reset}"
}

# Function to install requirements from a file
install_requirements() {
	local requirements_file="$1"
	local verbose="${2:-false}"

	display_message "$flag_icon" "$green" "Installing requirements from $requirements_file ..."
	if $verbose; then
		$PIP_CMD install -r "$requirements_file" || exit 1
	else
		$PIP_CMD install -r "$requirements_file" &>/dev/null || exit 1
	fi
	display_message "$flag_icon" "$green" "Requirements from $requirements_file installed successfully."
}

# Function to install packages from a file
install_internal_packages() {
	local file_path="$1"
	local verbose="${2:-false}"

	if [ -f "$file_path" ]; then
		display_message "$flag_icon" "$yellow" "Installing packages from $file_path ..."
		while IFS= read -r pkg; do
			pkg_name=$(echo "$pkg" | awk -F '==' '{print $1}')
			pkg_ver=$(echo "$pkg" | awk -F '==' '{print $2}')
			display_message "$flag_icon" "$yellow" "Installing ${pkg_name}@${pkg_ver}"
			if $verbose; then
				$PIP_CMD install "git+https://$GIT_TOKEN@github.com/BankBuddy/bud-core-${pkg_name}-lib@$pkg_ver" || {
					display_message "$cross_icon" "$red" "Failed to install ${pkg_name}@${pkg_ver}"
					continue
				}
			else
				$PIP_CMD install "git+https://$GIT_TOKEN@github.com/BankBuddy/bud-core-${pkg_name}-lib@$pkg_ver" &>/dev/null || {
					display_message "$cross_icon" "$red" "Failed to install ${pkg_name}@${pkg_ver}"
					continue
				}
			fi
		done <"$file_path"
		display_message "$flag_icon" "$green" "Requirements from $file_path installed successfully."
	else
		display_message "$cross_icon" "$red" "$file_path not found: $(pwd)"
		exit 1
	fi
}

# Parse command line arguments
verbose=false
while getopts "v" opt; do
	case $opt in
	v)
		verbose=true
		;;
	esac
done
shift $((OPTIND - 1))

# Install requirements from requirements.txt
if [ -f "requirements.txt" ]; then
	install_requirements "requirements.txt" "$verbose"
else
	display_message "$cross_icon" "$red" "Error: requirements.txt not found."
	exit 1
fi

# Install requirements from internal-requirements.txt
if [ -f "internal-requirements.txt" ]; then
	if [ -z "$GIT_TOKEN" ]; then
		display_message "$cross_icon" "$red" "Error: Git token not found in environment. Please set the GIT_TOKEN variable and try again."
		exit 1
	fi
	install_internal_packages "internal-requirements.txt" "$verbose"
else
	display_message "$cross_icon" "$red" "Error: internal-requirements.txt not found."
	exit 1
fi

display_message "$tick_icon" "$green" "All requirements installed!"

