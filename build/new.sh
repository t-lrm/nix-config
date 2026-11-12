#!/usr/bin/env bash

set -euo pipefail

HOSTS="./src/hosts"
FLAKE="./flake.nix"
MAKEFILE="./Makefile"
TEMPLATES="./build/templates"

err() {
    printf "Error:\n\t%s\n" "$*" >&2
    exit 1
}

if [ ! -d "./.git" ]; then
    err "You must run this script at the root of the repository."
fi

if ! git diff --quiet "$FLAKE" "$MAKEFILE" "$HOSTS"; then
    err "You have unstaged changes in $FLAKE, $MAKEFILE or $HOSTS."
fi

echo "=== CREATE A NEW MACHINE CONFIGURATION ==="

echo
echo "Hostname:"
read -r -p "> " hostname
if [[ ! "$hostname" =~ ^[A-Za-z_-]+$ ]]; then
    err "Invalid hostname '$hostname'" 
fi
if [ -e "$HOSTS/$hostname" ]; then
    err "Folder $HOSTS/$hostname already exists"
fi

echo
echo "Username:"
read -r -p "> " username
if [[ ! "$username" =~ ^[A-Za-z_.-]+$ ]]; then
    err "Invalid username '$username'"
fi

echo
echo "Type (nixos, darwin, home):"
read -r -p "> " type
if [[ ! "$type" =~ ^(nixos|darwin|home)$ ]]; then
    err "Invalid type '$type'"
fi

system="$(nix eval --impure --raw --expr builtins.currentSystem)"

echo
read -r -p "Use sytem '$system' [y/n]? " confirm

if [[ ! "$confirm" =~ ^[Yy]([Ee][Ss])?$ ]]; then
    echo
    echo "System (x86_64-linux, aarch64-darwin)"
    read -r -p "> " system
    if [[ ! "$system" =~ ^(x86_64-linux|aarch64-darwin)$ ]]; then
        err "Invalid system '$system'"
    fi
fi

block=$(cat <<EOF
    ${type}Configurations.$hostname = mkSystem {
      hostname = "$hostname";
      username = "$username";
      system = "$system";
      type = "$type";
    };
EOF
)

echo
echo "You're about to add this configuration to $FLAKE:"
echo
echo "$block"
echo
echo "The folder $HOSTS/$hostname will also be created."
echo

read -r -p "Are you sure [y/n]? " confirm

if [[ ! "$confirm" =~ ^[Yy]([Ee][Ss])?$ ]]; then
    echo "Abort."
    exit 0
fi

tmp=$(mktemp)
awk -v block="$block" '
  {
    lines[NR] = $0
  }
  END {
    for (i = 1; i <= NR; i++) {
      if (i == NR - 1) {
        print ""
        print block
      }
      print lines[i]
    }
  }
' "$FLAKE" > "$tmp"

cat "$tmp" > "$FLAKE"
rm "$tmp"

mkdir "$HOSTS/$hostname"
cp "$TEMPLATES/home.nix" "$HOSTS/$hostname"
cp "$TEMPLATES/configuration.nix" "$HOSTS/$hostname"
if [ -f "/etc/nixos/hardware-configuration.nix" ]; then
    cp "/etc/nixos/hardware-configuration.nix" "$HOSTS/$hostname"
fi

echo
echo "The configuration was created in $HOSTS/$hostname."
echo

if [ "$type" = "home" ]; then
    command="home-manager switch --flake .#$hostname"
else
    command="sudo ${type}-rebuild switch --flake .#$hostname"
fi

printf "\n$hostname:\n\t$command" >> "$MAKEFILE"

echo 
echo "You can now run 'make $hostname'"
