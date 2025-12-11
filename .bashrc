# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Enable shell options
shopt -s autocd         # Change to named directory
shopt -s cdspell        # Autocorrect cd misspellings
shopt -s cmdhist        # Save multi-line commands in history as single line
shopt -s dotglob        # Include hidden files in globs
shopt -s expand_aliases # Expand aliases
shopt -s checkwinsize   # Check terminal size when bash regains control

# Export settings
export TERM="xterm-256color"
export HISTCONTROL=ignoredups # No duplicate entries
export HISTSIZE=1000
export HISTFILESIZE=200000
export PATH="$HOME/.bin:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/go/bin:/opt/mold/bin:$HOME/.config/emacs/bin:$PATH"
export NVM_DIR="$HOME/.config/nvm"

if [ "$color_prompt" = yes ]; then
	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\]@\h:\w\$ '
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi


if [ -d ~/.bash_completion.d ]; then
    for file in ~/.bash_completion.d/* ; do
        [ -r "$file" ] && . "$file"
    done
fi

# Set default editor based on availability
if command -v nvim &>/dev/null; then
	export EDITOR='nvim'
elif command -v vim &>/dev/null; then
	export EDITOR='vim'
else
	export EDITOR='nano'
fi

# Set terminal title
case ${TERM} in
xterm* | rxvt* | Eterm* | aterm | kterm | gnome* | alacritty | st | konsole*)
	PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
	;;
screen*)
	PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
	;;
esac

# Load bash secret environment variables
if [ -f ~/.bash_envs ]; then
	. ~/.bash_envs
fi

# Load bash functions
if [ -f ~/.bash_functions ]; then
	. ~/.bash_functions
fi

# Load bash aliases
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# Load zoxide if installed
if command -v zoxide &>/dev/null; then
	eval "$(zoxide init bash)"
fi

# Load starship if installed
if command -v starship &>/dev/null; then
	eval "$(starship init bash)"
fi

if command -v fzf &>/dev/null; then
	eval "$(fzf --bash)"
fi


[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
. "$HOME/.cargo/env"

# >>>> Vagrant command completion (start)
. /opt/vagrant/embedded/gems/gems/vagrant-2.4.9/contrib/bash/completion.sh
# <<<<  Vagrant command completion (end)
