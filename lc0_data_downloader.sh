#!/bin/bash
# Naive downloader for lc0 training data

DATA_URL_PREFIX="https://storage.lczero.org/files/training_data/test80"

# where data is downloaded and processed
download_dir=~/data/test80-sep2022
cd $download_dir

# max concurrency 10, otherwise http 429 errors
xargs -P10 -a <(
  for filename in training-run1-test80-202209{01..31}-{00..23}17
  do
    echo $filename
  done
) -I{} \
  bash -c "ls -lth {}.binpack || ls -lth {}.tar || \
    (echo Downloading {}.tar ... && \
     wget -q $DATA_URL_PREFIX/{}.tar || \
     (echo Failed to download {}.tar ; rm {}.tar ))"

# clean up files from download errors (ie. files that don't exist)
find $download_dir -name "*.tar" -size 0 -delete
