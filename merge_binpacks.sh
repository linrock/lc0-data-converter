#!/bin/bash
# Merges all .binpack files in a directory

data_dir=/dev/shm
output_binpack=merged.binpack

rm -rf $output_binpack
python3 ./stockfish/script/interleave_binpacks.py \
  $(ls -1 $data_dir/*.plain.binpack | tr '\n' ' ' && echo $output_binpack)
ls -lth $output_binpack
