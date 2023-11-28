       if [ -d "../android/src/main/jniLibs" ]; then rm -r ../android/src/main/jniLibs
        fi
        if [ -d "../frameworks/rust_bdk_ffi.xcframework" ]; then rm -r ../frameworks/rust_bdk_ffi.xcframework
        fi

       mkdir -p ../android/src/main/jniLibs/arm64-v8a
       mkdir -p ../android/src/main/jniLibs/armeabi-v7a
       mkdir -p ../android/src/main/jniLibs/x86
       mkdir -p ../android/src/main/jniLibs/x86_86
       mkdir -p ../frameworks/bdk.0.29.3/

       cp target/aarch64-linux-android/release/librust_bdk_ffi.so  ../android/src/main/jniLibs/arm64-v8a
       cp target/armv7-linux-androideabi/release/librust_bdk_ffi.so  ../android/src/main/jniLibs/armeabi-v7a
       cp target/i686-linux-android/release/librust_bdk_ffi.so  ../android/src/main/jniLibs/x86
       cp target/x86_64-linux-android/release/librust_bdk_ffi.so  ../android/src/main/jniLibs/x86_86
       cp -r bdk.0.29.3/rust_bdk_ffi.xcframework ../frameworks/bdk.0.29.3/



