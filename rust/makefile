.DEFAULT_GOAL := help
PROJECTNAME=$(shell basename "$(PWD)")
SOURCES=$(sort $(wildcard ./src/*.rs ./src/**/*.rs))
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
all: init android xcframework unittest copy


unittest: unittest/bindings
unittest/bindings: $(SOURCES)
	  @echo "[Creating unittest ...] $@"
	  sh unittest.sh
	  @echo "[Done ✅]"


android: android/jniLibs
android/jniLibs: $(SOURCES)
	  @echo "[Creating android jniLibs ...] $@"
	  sh android.sh
	  @echo "[Done ✅]"

xcframework: darwin/xcframework
darwin/xcframework: $(SOURCES)
	  @echo "[Creating rust_bdk_ffi.xcframework ...] $@"
	  sh darwin.sh
	  @echo "[Done ✅]"

compress: compress/bindings
compress/bindings: $(SOURCES)
	 @echo "[COMPRESSING BINARIES TO FLUTTER PACKAGE ...] $@"
	sh compress.sh
	@echo "[Done ✅]"

copy: copy/bindings
copy/bindings: $(SOURCES)
	@echo "[COPYING BINARIES TO FLUTTER PACKAGE ...] $@"
	sh copy.sh
	@echo "[Done ✅]"



