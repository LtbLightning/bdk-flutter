       if [ -d "../android/src/main/jniLibs" ]; then rm -r ../android/src/main/jniLibs
        fi
        if [ -e "../ios/librust_bdk_ffi.a" ]; then rm ../ios/librust_bdk_ffi.a
        fi

       mkdir -p ../android/src/main/jniLibs/arm64-v8a
       mkdir -p ../android/src/main/jniLibs/armeabi-v7a
       mkdir -p ../android/src/main/jniLibs/x86
       # Name the native lib 'librust_bdk_ffi' when copying to avoid naming conflicts with other libs generated from a rust folder with flutter_rust_bridge
       cp target/aarch64-linux-android/release/librust.so  ../android/src/main/jniLibs/arm64-v8a/librust_bdk_ffi.so
       cp target/armv7-linux-androideabi/release/librust.so  ../android/src/main/jniLibs/armeabi-v7a/librust_bdk_ffi.so
       cp target/i686-linux-android/release/librust.so  ../android/src/main/jniLibs/x86/librust_bdk_ffi.so

       cp target/universal/release/librust.a  ../ios/librust_bdk_ffi.a

