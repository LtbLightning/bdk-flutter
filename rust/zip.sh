       if [ -d "../android/src/main/jniLibs" ]; then rm -r ../android/src/main/jniLibs
        fi
        if [ -e "../ios/librust.a" ]; then rm ../ios/librust.a
        fi


        mkdir  -p ../temp/aarch64-linux-android/release
        mkdir  -p ../temp/armv7-linux-androideabi/release
        mkdir  -p ../temp/i686-linux-android/release
        mkdir  -p ../temp/universal/release

        mkdir -p ../android/src/main/jniLibs/arm64-v8a
        mkdir -p ../android/src/main/jniLibs/armeabi-v7a
        mkdir -p ../android/src/main/jniLibs/x86

        cp target/aarch64-linux-android/release/librust.so  ../android/src/main/jniLibs/arm64-v8a
        cp target/armv7-linux-androideabi/release/librust.so  ../android/src/main/jniLibs/armeabi-v7a
       cp target/i686-linux-android/release/librust.so  ../android/src/main/jniLibs/x86
       cp target/universal/release/librust.a  ../ios/

                cp target/aarch64-linux-android/release/librust.so  ../temp/aarch64-linux-android/release
                  cp target/armv7-linux-androideabi/release/librust.so   ../temp/armv7-linux-androideabi/release
                     cp target/i686-linux-android/release/librust.so  ../temp/i686-linux-android/release
                       cp target/universal/release/librust.a ../temp/universal/release
