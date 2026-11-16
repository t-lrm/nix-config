.PHONY: help build

DISK_INIT ?= disk-init.nix

help:
	@printf "Usage:\n"
	@printf "\tmake help\t%s\n"  "Show this help message"
	@printf "\tmake new\t%s\n"   "Generate a new machine configuration"
	@printf "\tmake init\t%s\n"  "Initialize a new machine when using setting up a new machine"

new:
	@./build/new.sh

init:
	@[ -z "${HOST}" ] && echo "You must set the HOST variable" && exit 1
	@[ ! -d "src/hosts/${HOST}" ] && echo "Invalid host '${HOST}'" && exit 1
	@[ ! -f "src/hosts/${HOST}/${DISK_INIT}" ] && echo "Host '${HOST}' doesn't contain '${DISK_INIT}'" && exit 1
	
	sudo nix --extra-experimental-features 'nix-command flakes' \
		run github:nix-community/disko/latest -- \
		--mode destroy,format,mount "src/hosts/${HOST}/${DISK_INIT}"
	
	sudo nixos-generate-config --root /mnt --no-filesystems
	sudo cp "/etc/nixos/hardware-configuration.nix" "src/hosts/${HOST}/hardware-configuration.nix"

thinkpad:
	sudo nixos-rebuild switch --flake .#thinkpad

macbook:
	sudo darwin-rebuild switch --flake .#macbook

epita:
	home-manager switch --flake .#epita -b backup

headless-vm:
	sudo nixos-rebuild switch --flake .#headless-vm
