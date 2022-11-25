#!/bin/bash

data_dir=training-run1-test80-20221114-0017
rescorer rescore \
  --input=lc0-data/$data_dir/ \
  --syzygy-paths=./syzygy/345p:./syzygy/6p:./syzygy/7p \
  --nnue-plain-file=./output-data/$data_dir.plain \
  --threads=20
