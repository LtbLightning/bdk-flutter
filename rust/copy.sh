       if [ -d "../android/src/main/jniLibs" ]; then rm -r ../android/src/main/jniLibs
        fi
        if [ -e "../ios/librustbdk.a" ]; then rm ../ios/librustbdk.a
        fi

       mkdir -p ../android/src/main/jniLibs/arm64-v8a
       mkdir -p ../android/src/main/jniLibs/armeabi-v7a
       mkdir -p ../android/src/main/jniLibs/x86

       cp target/aarch64-linux-android/release/librust.so  ../android/src/main/jniLibs/arm64-v8a/librustbdk.so
       cp target/armv7-linux-androideabi/release/librust.so  ../android/src/main/jniLibs/armeabi-v7a/librustbdk.so
       cp target/i686-linux-android/release/librust.so  ../android/src/main/jniLibs/x86/librustbdk.so

       cp target/universal/release/librust.a  ../ios/librustbdk.a

