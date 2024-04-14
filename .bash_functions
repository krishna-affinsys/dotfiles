ex() {
    if [ -f "$1" ]; then
        case $1 in
        *.tar.bz2 | *.tbz2) tar xjf "$1" ;;
        *.tar.gz | *.tgz) tar xzf "$1" ;;
        *.bz2) bunzip2 "$1" ;;
        *.rar) unrar x "$1" ;;
        *.gz) gunzip "$1" ;;
        *.tar) tar xf "$1" ;;
        *.zip) unzip "$1" ;;
        *.Z) uncompress "$1" ;;
        *.7z) 7z x "$1" ;;
        *.deb) ar x "$1" ;;
        *.tar.xz) tar xf "$1" ;;
        *.tar.zst) unzstd "$1" ;;
        *) echo "'$1' cannot be extracted via ex()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

download() {
    local url="$1"
    local output_file="$2"

    if [ -z "$output_file" ]; then
        output_file=$(basename "$url")
    fi

    if command -v wget &>/dev/null; then
        wget -q --show-progress --progress=bar:force --no-check-certificate -O "$output_file" "$url" 2>&1
    else
        echo "Error: wget not found. Please install wget to use this function." >&2
        return 1
    fi
}

set-venv() {

    # Cross (✗) and Tick (✔) icons using Nerd Fonts
    cross_icon=$'\u2717'
    tick_icon=$'\u2714'

    # Colors
    red='\033[0;31m'
    green='\033[0;32m'
    reset='\033[0m'

    # Path to the virtual environment directory
    venv_dir="venv"

    # Check if the virtual environment directory exists
    if [ -d "$venv_dir" ]; then
        # Activate Python virtual environment
        source "$venv_dir/bin/activate" && echo -e "(${green}${tick_icon}${reset}) virtual environment activated."
    else
        echo -e "(${red}${cross_icon}${reset}) virtual environment directory not found: $(pwd)"
    fi

}

