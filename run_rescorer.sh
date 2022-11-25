#!/bin/bash

./rescorer rescore \
  --input=lc0-data/training-run1-test80-20221114-0017/ \
  --syzygy-paths=./syzygy/345m:./syzygy/6m \
  --nnue-plain-file=test.plain \
  --threads=20
