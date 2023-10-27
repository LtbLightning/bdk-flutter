#!/bin/bash

# Setup
BUILD_DIR=platform-build
mkdir $BUILD_DIR
cd $BUILD_DIR

# Build static libs
for TARGET in \
        aarch64-apple-ios x86_64-apple-ios aarch64-apple-ios-sim \
        x86_64-apple-darwin aarch64-apple-darwin
do
    rustup target add $TARGET
    cargo build -r --target=$TARGET
done

# Create XCFramework zip
FRAMEWORK="rust_bdk_ffi.xcframework"
LIBNAME=librust_bdk_ffi.a
TEST_LIBNAME=librust_bdk_ffi.dylib
mkdir -p mac-lipo ios-sim-lipo  bdk_bin_0.29.3/macos/

IOS_SIM_LIPO=ios-sim-lipo/$LIBNAME
MAC_LIPO=mac-lipo/$LIBNAME
MAC_TEST_LIPO=bdk_bin_0.29.3/macos/$TEST_LIBNAME

lipo -create -output $IOS_SIM_LIPO \
        ../target/aarch64-apple-ios-sim/release/$LIBNAME \
        ../target/x86_64-apple-ios/release/$LIBNAME
lipo -create -output $MAC_LIPO \
        ../target/aarch64-apple-darwin/release/$LIBNAME \
        ../target/x86_64-apple-darwin/release/$LIBNAME

lipo -create -output $MAC_TEST_LIPO \
        ../target/aarch64-apple-darwin/release/$TEST_LIBNAME \
        ../target/x86_64-apple-darwin/release/$TEST_LIBNAME

xcodebuild -create-xcframework \
        -library $IOS_SIM_LIPO \
        -library $MAC_LIPO \
        -library ../target/aarch64-apple-ios/release/$LIBNAME \
        -output $FRAMEWORK


## Cleanup
rm -rf ios-sim-lipo mac-lipo
