#!/bin/sh

        if [ -d "../android/src/main/jniLibs" ]; then rm -r ../android/src/main/jniLibs
        fi
        if [ -e "../ios/librust.a" ]; then rm ../ios/librust.a
        fi
#        if [ -d "target" ]; then rm -r target
#        fi
#        if [ -d "__MACOSX/" ]; then  rm -r __MACOSX/
#        fi
#        curl -L https://github.com/LtbLightning/bdk-flutter/releases/download/v0.1.2/target.zip --output target.zip
#        for file in target.zip
#                do
#                unzip -P pcp9100 "$file" -d $PWD/
#                rm "target.zip"
#
#                done
        mkdir -p ../android/src/main/jniLibs/arm64-v8a
        mkdir -p ../android/src/main/jniLibs/armeabi-v7a
        mkdir -p ../android/src/main/jniLibs/x86
        cp target/aarch64-linux-android/release/librust.so  ../android/src/main/jniLibs/arm64-v8a
        cp target/armv7-linux-androideabi/release/librust.so  ../android/src/main/jniLibs/armeabi-v7a
        cp target/i686-linux-android/release/librust.so  ../android/src/main/jniLibs/x86
        cp target/universal/release/librust.a  ../ios/

#        rm target/aarch64-linux-android/release/librust.so
#        rm target/armv7-linux-androideabi/release/librust.so
#        rm target/i686-linux-android/release/librust.so
#        rm target/universal/release/librust.a
#       rm -r __MACOSX/


