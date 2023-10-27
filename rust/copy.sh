       if [ -d "../android/src/main/jniLibs" ]; then rm -r ../android/src/main/jniLibs
        fi
        if [ -d "../darwin/rust_bdk_ffi.xcframework" ]; then rm -r ../darwin/rust_bdk_ffi.xcframework
        fi

       mkdir -p ../android/src/main/jniLibs/arm64-v8a
       mkdir -p ../android/src/main/jniLibs/armeabi-v7a
       mkdir -p ../android/src/main/jniLibs/x86

       cp target/aarch64-linux-android/release/librust_bdk_ffi.so  ../android/src/main/jniLibs/arm64-v8a
       cp target/armv7-linux-androideabi/release/librust_bdk_ffi.so  ../android/src/main/jniLibs/armeabi-v7a
       cp target/i686-linux-android/release/librust_bdk_ffi.so  ../android/src/main/jniLibs/x86
       cp -r platform-build/rust_bdk_ffi.xcframework ../darwin
       cd platform-build
       zip -r ../bdk_bin_0.29.3.zip bdk_bin_0.29.3
       cd ../
       rm -rf platform-build


