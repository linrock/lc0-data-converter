#!/bin/bash

tmpfile=$(mktemp /tmp/lc0-data-urls.XXXXXX)
for filename in training-run1-test80-202211{20..24}-{00..23}17
do
  echo $filename >> $tmpfile
done

cat $tmpfile | parallel -j 1 \
  wget https://storage.lczero.org/files/training_data/test80/{}.tar \
    -O ~/lc0-data/{}.tar

rm $tmpfile
