#!/bin/bash

url_prefix="https://storage.lczero.org/files/training_data/test78"

tmpfile=$(mktemp /tmp/lc0-data-urls.XXXXXX)
for filename in training-run3-test78-202210{11..20}-{00..23}22
do
  echo $filename >> $tmpfile
done

cat $tmpfile | xargs -P10 -I{} \
   bash -c "
     echo Downloading {}.tar && \
       wget -q $url_prefix/{}.tar -O ~/lc0-test78/{}.tar || \
       echo Failed to download {}.tar"

rm $tmpfile
