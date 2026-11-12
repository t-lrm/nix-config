.PHONY: help build

help:
	@echo -e "Usage:"
	@echo -e "\tmake help\t\tShow this help message"
	@echo -e "\tmake new\t\tGenerate a new machine configuration"

new:
	@./build/new.sh

thinkpad:
	sudo nixos-rebuild switch --flake .#thinkpad

macbook:
	sudo darwin-rebuild switch --flake .#macbook

epita:
	home-manager switch --flake .#epita -b backup
