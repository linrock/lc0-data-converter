#!/bin/bash
# Naive downloader for lc0 training data

LC0_DATASET=test77

# max concurrency 10, otherwise http 429 errors
DATASET_URL="https://storage.lczero.org/files/training_data/$LC0_DATASET"

# where data is downloaded and processed
download_dir=~/data/$lc0_dataset
mkdir -p $download_dir
cd $download_dir

xargs -P10 -a <(
  #  for filename in training-run1-test80-202209{01..31}-{00..23}17
  #  do
  #    echo $filename
  #  done
  curl -sL $DATASET_URL | grep -oE "training-run[^>]*tar" | sort -u | xargs -I{} basename {} .tar
) \
  -I{} \
    bash -c "ls -lth {}.binpack || ls -lth {}.tar || \
             (echo Downloading {}.tar ... && \
               wget -q $DATASET_URL/{}.tar || \
                 (echo Failed to download {}.tar ; rm {}.tar ))"

# clean up files from download errors (ie. files that don't exist)
find $download_dir -name "*.tar" -size 0 -delete
