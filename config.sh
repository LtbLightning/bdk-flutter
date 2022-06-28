# !/bin/sh
FILE=$PWD/ios/bdkFFI.xcframework/
 if [ -d "$FILE" ]; then
       echo "Already downloaded"
    else
        curl -L https://github.com/bitcoindevkit/bdk-swift/releases/download/0.3.0/bdkFFI.xcframework.zip --output $PWD/ios/Assets/bdkFFI.xcframework.zip
        for file in $PWD/ios/Assets/bdkFFI.xcframework.zip
        do
        unzip -P pcp9100 "$file" -d $PWD/ios/
        rm "$PWD/ios/Assets/bdkFFI.xcframework.zip"
        done
    fi


