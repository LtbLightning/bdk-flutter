.DEFAULT_GOAL := help
PROJECTNAME=$(shell basename "$(PWD)")
SOURCES=$(sort $(wildcard ./src/*.rs ./src/**/*.rs))

OS_NAME=$(shell uname | tr '[:upper:]' '[:lower:]')
PATH := $(ANDROID_NDK_HOME)/24.0.8215888/toolchains/llvm/prebuilt/$(OS_NAME)-x86_64/bin:$(PATH)
BINPATH = $(ANDROID_NDK_HOME)/24.0.8215888/toolchains/llvm/prebuilt/$(OS_NAME)-x86_64/bin

ANDROID_AARCH64_LINKER=$(BINPATH)/aarch64-linux-android29-clang
ANDROID_AARCH64_AR=$(BINPATH)/aarch64-linux-android-ar
ANDROID_ARMV7_LINKER=$(BINPATH)/armv7a-linux-androideabi29-clang
ANDROID_ARM_AR=$(BINPATH)/arm-linux-androideabi-ar
ANDROID_I686_LINKER=$(BINPATH)/i686-linux-android29-clang
ANDROID_I686_AR=$(BINPATH)/i686-linux-android-ar
ANDROID_X86_64_LINKER=$(BINPATH)/x86_64-linux-android29-clang
ANDROID_X86_64_AR=$(BINPATH)/x86_64-linux-android-ar

SHELL := /bin/bash

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
.PHONY: init
init:

	rustup target add aarch64-apple-ios x86_64-apple-ios
	rustup target add aarch64-apple-darwin x86_64-apple-darwin
	#rustup target add armv7-apple-ios armv7s-apple-ios i386-apple-ios ## deprecated
	rustup target add aarch64-linux-android armv7-linux-androideabi i686-linux-android x86_64-linux-android
	@if [ $$(uname) == "Darwin" ] ; then cargo install cargo-lipo ; fi


## :

# ##############################################################################
# # RECIPES
# ##############################################################################

## all: Compile iOS, Android and bindings targets
all:  init

## ios: Compile the iOS universal library
ios: target/universal/release/libexample.a

target/universal/release/libexample.a:
	cargo lipo --release
	@echo "[DONE] $@"

## macos: Compile the macOS libraries
macos: target/x86_64-apple-darwin/release/libexample.dylib target/aarch64-apple-darwin/release/libexample.dylib

target/x86_64-apple-darwin/release/libexample.dylib: $(SOURCES)
	@if [ $$(uname) == "Darwin" ] ; then \
		cargo lipo --release --targets x86_64-apple-darwin ; \
		else echo "Skipping macOS compilation on $$(uname)" ; \
	fi
	@echo "[DONE] $@"

target/aarch64-apple-darwin/release/libexample.dylib: $(SOURCES)
	@if [ $$(uname) == "Darwin" ] ; then \
		cargo lipo --release --targets aarch64-apple-darwin ; \
		else echo "Skipping macOS compilation on $$(uname)" ; \
	fi
	@echo "[DONE] $@"

## android: Compile the android targets (arm64, armv7 and i686)
android: target/aarch64-linux-android/release/libexample.so target/armv7-linux-androideabi/release/libexample.so target/i686-linux-android/release/libexample.so target/x86_64-linux-android/release/libexample.so

target/aarch64-linux-android/release/libexample.so:

	cargo ndk -t armeabi-v7a build --release
	@echo "[DONE] $@"

target/armv7-linux-androideabi/release/libexample.so:
	cargo ndk -t arm64-v8a build --release
	@echo "[DONE] $@"

target/i686-linux-android/release/libexample.so:
	cargo ndk  -t x86 build --release
	@echo "[DONE] $@"

target/x86_64-linux-android/release/libexample.so:
	cargo ndk  -t x86_64 build --release
	@echo "[DONE] $@"


## bindings: Generate the .h file for iOS
bindings: target/bindings.h

target/bindings.h: $(SOURCES)
#	cbindgen $^ -c cbindgen.toml | grep -v \#include | uniq > $@
	 @echo "[MOVED UP] $@"
	 flutter_rust_bridge_codegen --rust-input rust/src/api.rs --dart-output lib/src/generated/bindings.dart --c-output ios/Classes/bindings.h
	@echo "[DONE] $@"

# ##############################################################################
# # OTHER
# ##############################################################################

## clean:
.PHONY: clean
clean:
	cargo clean
	rm -f target/bindings.h

## test:
.PHONY: test
test:
	cargo test