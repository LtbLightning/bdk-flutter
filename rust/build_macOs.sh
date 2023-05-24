#!/bin/bash
TEMP=temp_dir
MACOS=target/universal/release/macOs
LIBNAME=librust_bdk_ffi.a
FRAMEWORK=bdk_ffi.xcframework

for TARGET in \
         $TEMP $MACOS
do
    if [ -d $TARGET ]; then rm -r $TARGET
    fi
done

# Build static libs
for TARGET in \
         x86_64-apple-darwin aarch64-apple-darwin
do
     cargo build -r --target=$TARGET
done

mkdir $TEMP
mkdir $MACOS
lipo -create -output  $TEMP/$LIBNAME \
        target/aarch64-apple-darwin/release/$LIBNAME \
        target/x86_64-apple-darwin/release/$LIBNAME
xcodebuild -create-xcframework \
        -library $TEMP/$LIBNAME \
        -output $TEMP/$FRAMEWORK
cp $TEMP/$FRAMEWORK/macos-arm64_x86_64/$LIBNAME   $MACOS/

# Cleanup
rm -rf $TEMP