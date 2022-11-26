#!/bin/bash
# Naive downloader for lc0 training data
 
url_prefix="https://storage.lczero.org/files/training_data/test78"
download_dir="~/lc0-test78"

tmpfile=$(mktemp /tmp/lc0-data-urls.XXXXXX)
for filename in training-run3-test78-202209{15..30}-{00..23}{21,22}
do
  echo $filename >> $tmpfile
done

# max concurrency 10, otherwise 429 errors
xargs -a $tmpfile -P10 -I{} \
  bash -c "echo Downloading {}.tar && \
    wget -q $url_prefix/{}.tar -O $download_dir/{}.tar || \
    echo Failed to download {}.tar"

find $download_dir -size 0 -delete
rm $tmpfile
