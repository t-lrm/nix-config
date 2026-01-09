# --- Aliases ---

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

# Run clang-format on a whole repo
formatc() {
  find . -iname '*.h' -o -iname '*.c' | xargs clang-format -i
}

# Fail if not inside a git work tree
_require_git_repo() {
  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "$1: not a git repository"
    return 1
  fi
}

# Print the next tag name for a given prefix (e.g. "archi" -> "archi-7")
_next_tag() {
  local prefix="$1"
  local max=0 t num

  while IFS= read -r t; do
    num=${t#"$prefix-"}              # strip "<prefix>-"
    if [[ $num =~ ^[0-9]+$ ]]; then
      num=$((10#$num))              # force base-10
      (( num > max )) && max=$num
    fi
  done < <(git tag -l "${prefix}-*")

  printf '%s-%d\n' "$prefix" $((max + 1))
}

# Create and push a sequential tag for a prefix.
# Usage: _tag_and_push <prefix> [confirm=0|1]
_tag_and_push() {
  local prefix="$1"
  local confirm="${2:-0}"
  local tag

  _require_git_repo "$prefix" || return 1

  tag="$(_next_tag "$prefix")" || return 1

  if (( confirm )); then
    echo "About to run: git tag -a '$tag' -m '$tag'"
    local answer
    read -r -p "Continue? [y/N] " answer
    case "$answer" in
      [yY]|[yY][eE][sS]) ;;
      *) echo "Aborted."; return 1 ;;
    esac
  fi

  git tag -a "$tag" -m "$tag" || { echo "Failed to create tag"; return 1; }
  echo "Created tag $tag"

  echo "Pushing tag '$tag' to 'origin'..."
  git push origin "$tag" || { echo "Failed to push tag"; return 1; }

  echo "$prefix: done (pushed $tag)"
}

archi()  { _tag_and_push archi  0; }
submit() { _tag_and_push submit 1; }