.DEFAULT_GOAL := help
PROJECTNAME=$(shell basename "$(PWD)")
# ##############################################################################
# # GENERAL
# ##############################################################################

.PHONY: help
help: makefile
	@echo
	@echo " Available actions in "$(PROJECTNAME)":"
	@echo
	@sed -n 's/^##//p' $< | column -t -s ':' |  sed -e 's/^/ /'
	@echo

## init: Install missing dependencies.
init:
	cargo install flutter_rust_bridge_codegen
	cargo install cargo-ndk
	@if [ $$(uname) == "Darwin" ] ; then cargo install cargo-lipo ; fi
## :

## all: Compile iOS, Android and bindings targets
all: init build-jnilib build-xcframework build-unittest copy-build compress-build


build-jnilib:
	  @echo "[Creating android jniLibs ...] $@"
	  sh android.sh
	  @echo "[Done ✅]"

build-xcframework:
	  @echo "[Creating rust_bdk_ffi.xcframework ...] $@"
	  sh darwin.sh
	  @echo "[Done ✅]"

build-unittest:
	  @echo "[Creating unittest ...] $@"
	  sh unittest.sh
	  @echo "[Done ✅]"

compress-build:
	@echo "[COMPRESSING BINARIES TO FLUTTER PACKAGE ...] $@"
	sh compress.sh
	@echo "[Done ✅]"

copy-build:
	@echo "[COPYING BINARIES TO FLUTTER PACKAGE ...] $@"
	sh copy.sh
	@echo "[Done ✅]"








