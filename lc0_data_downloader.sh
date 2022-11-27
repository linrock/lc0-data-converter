#!/bin/bash
# Naive downloader for lc0 training data

download_dir="~/data/test80/nov2022"
url_prefix="https://storage.lczero.org/files/training_data/test80"

# max concurrency 10, otherwise 429 errors
xargs -P10 -a <(
  for filename in training-run1-test80-202211{01..31}-{00..23}17
  do
    echo $filename
  done
) -I{} \
  bash -c "echo Downloading {}.tar && \
    wget -q $url_prefix/{}.tar -O $download_dir/{}.tar || \
    echo Failed to download {}.tar"

# clean up files from download errors (ie. files that don't exist)
find $download_dir -size 0 -delete
