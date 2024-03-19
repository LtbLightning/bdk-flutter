.DEFAULT_GOAL := help
PROJECTNAME=$(shell basename "$(PWD)")

.PHONY: help
help: makefile
	@echo
	@echo " Available actions in "$(PROJECTNAME)":"
	@echo
	@sed -n 's/^##//p' $< | column -t -s ':' |  sed -e 's/^/ /'
	@echo

## init: Install missing dependencies.
init:
	cargo install 'flutter_rust_bridge_codegen@^2.0.0-dev.28'
## :

all: init generate-bindings

generate-bindings:
	@echo "[GENERATING FRB CODE] $@"
	flutter_rust_bridge_codegen generate
	@echo "[Done ✅]"







