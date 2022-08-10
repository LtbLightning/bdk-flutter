#!/bin/sh
FILE=target
 if [ -d "$FILE" ]; then
       echo "Already downloaded"
    else
        curl -L https://github.com/LtbLightning/bdk-flutter/releases/download/0.1.1/target.zip --output target.zip
        for file in target.zip
                do
                unzip -P pcp9100 "$file" -d $PWD/
                rm "target.zip"
                rm -r "__MACOSX"
                done
    fi
