#!/bin/bash
FILE=config.txt
BIN_V="oop_v0.1.0"
if [ ! -e "$FILE" ];
then  bash unzip.sh
else
  source $FILE
  if [ $VERSION == $BIN_V ];
  then echo "Version: $VERSION"
  else
       bash unzip.sh
   fi
fi

