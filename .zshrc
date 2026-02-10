# Download Znap, if it's not there yet.
#
[[ -r ~/.config/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/.config/znap
source ~/.config/znap/znap.zsh

# ============================================================================
# ZSH Options (equivalent to bash shopt)
# ============================================================================
setopt AUTO_CD              # Type directory name to cd
setopt CORRECT              # Autocorrect commands (like cdspell)
setopt EXTENDED_GLOB        # Advanced globbing (includes dotglob behavior)
setopt APPEND_HISTORY       # Append to history file
setopt SHARE_HISTORY        # Share history between sessions
setopt HIST_IGNORE_DUPS     # No duplicate entries
setopt HIST_FIND_NO_DUPS    # Don't show duplicates in search
setopt INTERACTIVE_COMMENTS # Allow comments in interactive shell

# ============================================================================
# History Configuration
# ============================================================================
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=200000

# ============================================================================
# Path Configuration
# ============================================================================
export PATH="$HOME/.bin:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/go/bin:$PATH"
export PATH="$(brew --prefix)/opt/python@3.11/libexec/bin:$PATH"
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"
# export PATH="/opt/homebrew/share/google-cloud-sdk/bin:$PATH"

# Add GNU coreutils if installed (for Linux-like commands on macOS)
if [[ -d "$(brew --prefix)/opt/coreutils/libexec/gnubin" ]]; then
    export PATH="$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH"
fi

# ============================================================================
# Editor Configuration
# ============================================================================
if command -v nvim &>/dev/null; then
    export EDITOR='nvim'
    export VISUAL='nvim'
elif command -v vim &>/dev/null; then
    export EDITOR='vim'
    export VISUAL='vim'
else
    export EDITOR='nano'
    export VISUAL='nano'
fi

# ============================================================================
# Terminal Configuration
# ============================================================================
export TERM="xterm-256color"

# Set terminal title (zsh way)
precmd() {
    print -Pn "\e]0;%n@%m:%~\a"
}

# ============================================================================
# Completion System
# ============================================================================
autoload -Uz compinit
# Only regenerate compdump once a day for speed
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
    compinit
else
    compinit -C
fi

# Case-insensitive completion (nice for macOS)
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# Colored completion (ls colors)
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# ============================================================================
# Znap Plugins
# ============================================================================
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting
znap source ohmyzsh/ohmyzsh lib/git.zsh
znap source ohmyzsh/ohmyzsh plugins/git

# ============================================================================
# Modern CLI Tools
# ============================================================================
# Starship prompt
znap eval starship 'starship init zsh --print-full-init'
znap prompt

# Zoxide (better cd)
if command -v zoxide &>/dev/null; then
    znap eval zoxide "zoxide init zsh"
fi

# FZF (fuzzy finder)
if command -v fzf &>/dev/null; then
    eval "$(fzf --zsh)"
fi

znap eval gcloud 'source /opt/homebrew/share/google-cloud-sdk/path.zsh.inc'
znap eval gcloud 'source /opt/homebrew/share/google-cloud-sdk/completion.zsh.inc'

# ============================================================================
# NVM Configuration (lazy loading for speed)
# ============================================================================
export NVM_DIR="$HOME/.config/nvm"
if [ -s "$(brew --prefix nvm)/nvm.sh" ]; then
    alias nvm='unalias nvm && source "$(brew --prefix nvm)/nvm.sh" && nvm'
    alias node='unalias node && source "$(brew --prefix nvm)/nvm.sh" && node'
    alias npm='unalias npm && source "$(brew --prefix nvm)/nvm.sh" && npm'
fi

# ============================================================================
# Cargo (Rust)
# ============================================================================
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# ============================================================================
# Custom Aliases
# ============================================================================
alias cd='z'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

if command -v eza &>/dev/null; then
    alias ls='eza --icons --group-directories-first'
    alias ll='eza -l --icons --group-directories-first'
    alias la='eza -la --icons --group-directories-first'
    alias lt='eza --tree --icons --group-directories-first'
else
    alias ls='ls -G'  # macOS color flag
    alias ll='ls -lhG'
    alias la='ls -lahG'
fi

alias vim="nvim"
alias pip="uv pip"

# Secret environment variables
[[ -f ~/.zsh_envs ]] && source ~/.zsh_envs

# ============================================================================
# macOS Optimizations
# ============================================================================
export HOMEBREW_NO_AUTO_UPDATE=1  # Disable auto-update (speeds up brew commands)
export HOMEBREW_NO_ANALYTICS=1     # Disable analytics

