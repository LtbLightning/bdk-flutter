#This is a script which is not being used at the moment but keeping in the repository in case it is required in the future
        if [ -d "../android/src/main/jniLibs" ]; then rm -r ../android/src/main/jniLibs
        fi
        if [ -e "../ios/librust.a" ]; then rm ../ios/librust.a
        fi
        if [ -e "config.txt " ]; then rm config.txt
        fi
         mkdir -p temp
         echo "Downloading Version: OOP_v0.1.0"
        curl  -s  -L   https://github.com/LtbLightning/bdk-flutter/releases/download/v0.1.3/target.zip --output temp/target.zip
        for file in temp/target.zip
                do
                unzip  -q -P pcp9100 "$file" -d $PWD/temp/
                rm "temp/target.zip"
                done
        mkdir -p ../android/src/main/jniLibs/arm64-v8a
        mkdir -p ../android/src/main/jniLibs/armeabi-v7a
        mkdir -p ../android/src/main/jniLibs/x86
        cp temp/target/aarch64-linux-android/release/librust.so  ../android/src/main/jniLibs/arm64-v8a
        cp temp/target/armv7-linux-androideabi/release/librust.so  ../android/src/main/jniLibs/armeabi-v7a
        cp temp/target/i686-linux-android/release/librust.so  ../android/src/main/jniLibs/x86
        cp temp/target/universal/release/librust.a  ../ios/

        rm -r temp/