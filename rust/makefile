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
	rustup target add aarch64-apple-ios x86_64-apple-ios
	rustup target add aarch64-apple-darwin x86_64-apple-darwin
	#rustup target add armv7-apple-ios armv7s-apple-ios i386-apple-ios ## deprecated
	rustup target add aarch64-linux-android armv7-linux-androideabi i686-linux-android x86_64-linux-android
	cargo install flutter_rust_bridge_codegen
	cargo install cargo-ndk
	@if [ $$(uname) == "Darwin" ] ; then cargo install cargo-lipo ; fi
## :

## all: Compile iOS, Android and bindings targets
all: init ios android bindings

## ios: Compile the iOS universal library
ios: target/universal/release/libexample.a
target/universal/release/libexample.a:
	cargo lipo --release
	@echo "[Done ✅] $@"

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

bindings: copy/bindings
copy/bindings: $(SOURCES)
#	cbindgen $^ -c cbindgen.toml | grep -v \#include | uniq > $@
	 @echo "[COPYING BINARIES TO FLUTTER PACKAGE ...] $@"
	sh copy.sh
	@echo "[Done ✅]"
	@echo "[*** ALL TASKS Completed ✅ ***]"


