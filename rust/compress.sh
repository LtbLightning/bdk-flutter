#!/bin/bash

for TARGET in \
        bdk.0.30.0 unittest.bdk.0.30.0
do
    zip -r $TARGET.zip $TARGET
    rm -rf $TARGET
done



