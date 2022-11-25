#!/bin/bash
# Takes lc0 .tar data files, rescores them with tablebases,
# and converts them to .plain for stockfish to process later
# Run this inside the container

for filepath in ./lc0-data/*.tar; do
  tarfile=$(basename $filepath)
  dirname=$(basename $tarfile .tar)

  echo Extracting $tarfile ...
  tar xvf $filepath -C ./lc0-data > /dev/null

  rescorer rescore \
    --input=./lc0-data/$dirname \
    --syzygy-paths=./syzygy/345p:./syzygy/6p:./syzygy/7p \
    --nnue-plain-file=./output-data/$dirname.plain \
    --threads=20

  rm -rf ./lc0-data/$dirname
done
