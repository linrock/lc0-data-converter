#!/bin/bash
# Merges all .binpack files in a directory
if [ "$#" -ne 1 ]; then
  echo "Usage: ./merge_binpacks.sh <data_dir>"
  exit 0
fi

output_binpack=merged.binpack

# rm -f $output_binpack
python3 ./stockfish/script/interleave_binpacks.py \
  $(ls -1 $1/*.binpack | tr '\n' ' ' && echo $output_binpack)
ls -lth $output_binpack
