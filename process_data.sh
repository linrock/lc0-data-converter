#!/bin/bash

for dirname in ./lc0-data/*/; do
  rescorer rescore \
    --input=$dirname \
    --syzygy-paths=./syzygy/345p:./syzygy/6p:./syzygy/7p \
    --nnue-plain-file=./output-data/$(basename $dirname).plain \
    --threads=20
done
