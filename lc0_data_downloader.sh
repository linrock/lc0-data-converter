#!/bin/bash
# Downloads lc0 training data from the given dataset in chronological order

LC0_DATASET=test80
DATASET_URL="https://storage.lczero.org/files/training_data/$LC0_DATASET"

# where data is downloaded and processed
download_dir=~/data/$LC0_DATASET
echo Downloading to $download_dir
mkdir -p $download_dir

# Example of manually specifying filenames to download
#  for filename in training-run1-test80-202209{01..31}-{00..23}17
#  do
#    echo $filename
#  done

# max concurrency 10, otherwise http 429 errors
xargs -P 10 -a <(
  curl -sL $DATASET_URL | grep -oE "training-run[^>]*tar" | sort -u | \
    xargs -I{} basename {} .tar    # | grep 20220[67]
) \
  -I{} \
    bash -c "ls -lth {}.binpack || ls -lth {}.tar || \
             (echo Downloading {}.tar ... && \
               wget -q $DATASET_URL/{}.tar -P $download_dir || \
                 (echo Failed to download {}.tar ; rm {}.tar ))"

# clean up files from download errors (ie. files that don't exist)
# find $download_dir -name "*.tar" -size 0 -delete
