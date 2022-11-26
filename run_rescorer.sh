#!/bin/bash
# Takes lc0 .tar data files, rescores them with tablebases,
# and converts them to .plain for stockfish to process later

data_dir=./test80-data

for filepath in $data_dir/*.tar; do
  tarfile=$(basename $filepath)
  dirname=$(basename $tarfile .tar)

  echo Extracting $tarfile ...
  tar xvf $filepath -C $data_dir > /dev/null

  rescorer rescore \
    --input=$data_dir/$dirname \
    --syzygy-paths=./syzygy/345p:./syzygy/6p:./syzygy/7p \
    --nnue-plain-file=./output-data/$dirname.plain \
    --threads=20

  rm -rf $data_dir/$dirname
done
