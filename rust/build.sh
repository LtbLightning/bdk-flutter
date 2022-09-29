#!/bin/bash
FILE=config.txt
BIN_V="v0.1.1"
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

