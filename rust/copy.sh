       if [ -d "../android/src/main/jniLibs" ]; then rm -r ../android/src/main/jniLibs
        fi
        if [ -e "../ios/libbdk.a" ]; then rm ../ios/libbdk.a
        fi

       mkdir -p ../android/src/main/jniLibs/arm64-v8a
       mkdir -p ../android/src/main/jniLibs/armeabi-v7a
       mkdir -p ../android/src/main/jniLibs/x86
       # Name the native lib 'libbdk' when copying to avoid naming conflicts with other libs generated from a rust folder with flutter_rust_bridge
       cp target/aarch64-linux-android/release/librust.so  ../android/src/main/jniLibs/arm64-v8a/libbdk.so
       cp target/armv7-linux-androideabi/release/librust.so  ../android/src/main/jniLibs/armeabi-v7a/libbdk.so
       cp target/i686-linux-android/release/librust.so  ../android/src/main/jniLibs/x86/libbdk.so

       cp target/universal/release/librust.a  ../ios/libbdk.a

