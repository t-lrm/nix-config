help:
	@echo -e "Usage:"
	@echo -e "\tmake help\t\tShow this help message"
	@echo -e "\tmake new\t\tGenerate a new machine configuration"

new:
	@./build/new.sh

.PHONY: help build
