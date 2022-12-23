#!/bin/bash
# Downloads lc0 training data from the given dataset in chronological order

LC0_DATASET=test80
DATASET_URL="https://storage.lczero.org/files/training_data/$LC0_DATASET"

# where data is downloaded and processed
download_dir=~/data/$LC0_DATASET
echo Downloading to $download_dir
mkdir -p $download_dir
cd $download_dir

function download_training_data() {
  dataset_url=$1
  filename=$2
  tar_filename=${filename}.tar

  if ls -lth ${filename}.*.binpack 2>/dev/null; then
    echo Found binpacks for ${filename} - not downloading
  elif ls -lth $tar_filename 2>/dev/null; then
    echo Found $tar_filename - not downloading
  else
    echo Downloading $tar_filename ...
    echo $dataset_url/$tar_filename
    wget $dataset_url/$tar_filename
    # (echo Failed to download {}.tar ; rm {}.tar ))"
  fi
}
export -f download_training_data

# Example of manually specifying filenames to download
#  for filename in training-run1-test80-202209{01..31}-{00..23}17
#  do
#    echo $filename
#  done

# max concurrency 10, otherwise http 429 errors
xargs -P 10 -a <(
  curl -sL $DATASET_URL | grep -oE "training-run[^>]*tar" | sort -u | \
    xargs -I{} basename {} .tar | grep 202212
) -I{} bash -c 'download_training_data "$@"' _ $DATASET_URL {}

# clean up files from download errors (ie. files that don't exist)
# find $download_dir -name "*.tar" -size 0 -delete
