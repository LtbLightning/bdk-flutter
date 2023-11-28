#!/bin/bash

for TARGET in \
        bdk.0.29.3 unittest.bdk.0.29.3
do
    zip -r $TARGET.zip $TARGET
done
rm  unittest.bdk.0.29.3

