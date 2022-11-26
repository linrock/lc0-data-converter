#!/bin/bash
# Takes lc0 .tar data files, rescores them with tablebases,
# and converts them to .plain for stockfish to process later
# Run this inside the container

for filepath in ./test80-data/*.tar; do
  tarfile=$(basename $filepath)
  dirname=$(basename $tarfile .tar)

  echo Extracting $tarfile ...
  tar xvf $filepath -C ./test80-data > /dev/null

  rescorer rescore \
    --input=./test80-data/$dirname \
    --syzygy-paths=./syzygy/345p:./syzygy/6p:./syzygy/7p \
    --nnue-plain-file=./output-data/$dirname.plain \
    --threads=20

  rm -rf ./test80-data/$dirname
done
