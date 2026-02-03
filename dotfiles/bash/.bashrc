# Basic shortcuts
alias ll='eza --icons=always --hyperlink --sort=name'
alias la='eza --all --long --icons=always --hyperlink --sort=name --total-size --git'
alias lt='eza --tree --icons=always --hyperlink --group-directories-first --sort=name --total-size --git --all --ignore-glob="__pycache__|.venv|.git|.idea|.vscode"'
alias ..='cd ..'
alias ...='cd ../..'
alias t3='tree . -I "obj|bin|.idea|.git" -a'

# Git shortcuts
alias gs='git status'
alias ga='git add'
alias gap='git add -Ap'
alias gc='git commit -m'
alias gcl='git clone'
alias gp='git push'
alias gpt='git push --follow-tags'
alias gt='git tag -ma'
alias gd='git diff'
alias gds='git diff --staged'
alias gr='git restore -p'
alias grs='git restore --staged'
alias gl='git log --all --graph --decorate=full'

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
