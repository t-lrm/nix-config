# Basic shortcuts
alias ll='ls -alF --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias t3='tree . -I "obj|bin|.idea|.git" -a'

# Git shortcuts
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gpt='git push --follow-tags'
alias gt='git tag -ma'
alias gd='git diff'

# Python virtualenv helper
alias venv='source .venv/bin/activate'

# --- Functions ---

# Quick mkcd - make directory and cd into it
mkcd () {
    mkdir -p "$1" && cd "$1"
}

# Copy text to clipboard
cb () {
    xclip -selection clipboard < "$1"
}
