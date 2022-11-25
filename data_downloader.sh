#!/bin/bash

for filename in training-run1-test80-202211{18..24}-{00..23}17
do
  wget https://storage.lczero.org/files/training_data/test80/$filename.tar
done
