#!/bin/bash
# Naive downloader for lc0 training data

download_dir="~/data/test80-sep2022"
url_prefix="https://storage.lczero.org/files/training_data/test80"

# max concurrency 10, otherwise http 429 errors
xargs -P10 -a <(
  for filename in training-run1-test80-202209{01..31}-{00..23}17
  do
    echo $filename
  done
) -I{} \
  bash -c "ls -lth $download_dir/{}.binpack || ls -lth $download_dir/{}.tar || \
    (echo Downloading {}.tar ... && \
     wget -q $url_prefix/{}.tar -O $download_dir/{}.tar || \
     echo Failed to download {}.tar)"

# clean up files from download errors (ie. files that don't exist)
find $download_dir -name "*.tar" -size 0 -delete
