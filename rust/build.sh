#!/bin/bash
FILE=config.txt
BIN_V="oop_v0.1.0"
if [ ! -e "$FILE" ];
then  bash config_binary.sh
else
  source $FILE
  if [ $VERSION == $BIN_V ];
  then echo "Version: $VERSION"
  else
       bash config_binary.sh
   fi
fi

