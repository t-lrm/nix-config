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

# Quick mkcd - make directory and cd into it
mkcd () {
    mkdir -p "$1" && cd "$1"
}

# Copy text to clipboard
cb() {
  if command -v pbcopy >/dev/null 2>&1; then
    pbcopy < "$1"
  elif command -v xclip >/dev/null 2>&1; then
    xclip -selection clipboard < "$1"
  else
    echo "No clipboard tool found"
    return 1
  fi
}

makeinit() {
  cat > Makefile <<'EOF'
CC = gcc
CPPFLAGS = -MMD
CFLAGS = -Wall -Wextra -Werror -O3
LDFLAGS =
LDLIBS =

SRC = main.c average.c max.c
OBJ = ${SRC:.c=.o}
DEP = ${SRC:.c=.d}

all: main

main: ${OBJ}

clean:
	${RM} ${OBJ}
	${RM} ${DEP}
	${RM} main

.PHONY: all clean

-include ${DEP}
EOF

  echo "Info: if you want to import a dynamic library, use:"
  echo '  $(pkg-config --cflags <package-name>)'
  echo '  $(pkg-config --libs <package-name>)'
  echo
  echo "Use 'pkg-config --list-all' to list the available packages."
}
