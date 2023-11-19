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
	rustup target add aarch64-linux-android armv7-linux-androideabi i686-linux-android x86_64-linux-android
	cargo install flutter_rust_bridge_codegen
	cargo install cargo-ndk
	@if [ $$(uname) == "Darwin" ] ; then cargo install cargo-lipo ; fi
## :

## all: Compile iOS, Android and bindings targets
all: init android xcframework bindings

## android: Compile the android targets (arm64, armv7 and i686)
android: target/aarch64-linux-android/release/libexample.so target/armv7-linux-androideabi/release/libexample.so target/i686-linux-android/release/libexample.so
target/aarch64-linux-android/release/libexample.so: $(SOURCES)
		    cargo ndk -t arm64-v8a build --release
	@echo "[Done ✅] $@"
target/armv7-linux-androideabi/release/libexample.so: $(SOURCES)
		 cargo ndk -t armeabi-v7a build --release
	@echo "[Done ✅] $@"
target/i686-linux-android/release/libexample.so: $(SOURCES)
		cargo ndk -t x86 build --release
	@echo "[Done ✅] $@"
target/x86_64-linux-android/release/libexample.so: $(SOURCES)
		 cargo ndk -t x86_64 build --release
	@echo "[Done ✅] $@"


xcframework: darwin/xcframework
darwin/xcframework: $(SOURCES)
	  @echo "[Creating rust_bdk_ffi.xcframework ...] $@"
	  sh darwin.sh
	  @echo "[Done ✅]"

bindings: copy/bindings
copy/bindings: $(SOURCES)
	 @echo "[COPYING BINARIES TO FLUTTER PACKAGE ...] $@"
	sh copy.sh
	@echo "[Done ✅]"
	@echo "[*** ALL TASKS Completed ✅ ***]"


