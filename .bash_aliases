alias bashconfig='$EDITOR ~/.bashrc'
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias cd='z'
alias vim='nvim'

# alias ls='eza -al --color=always --group-directories-first' # my preferred listing
# alias la='eza -a --color=always --group-directories-first'  # all files and dirs
# alias ll='eza -l --color=always --group-directories-first'  # long format
# alias lt='eza -aT --color=always --group-directories-first' # tree listing
# alias l.='eza -a | egrep "^\."'

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias df='df -h'     # Human-readable sizes
alias free='free -m' # Display memory in MBs

alias psa='ps auxf'
alias psgrep='ps aux | grep -v grep | grep -i -e VSZ -e'
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'

alias tb='nc termbin.com 9999'

if [ -d "$HOME/.scripts" ]; then
	for script in "$HOME/.scripts"/*; do
		if [ -f "$script" ] && [ -x "$script" ]; then
			script_name=$(basename "$script")
			alias "${script_name%.*}"="$script"
		fi
	done
fi
