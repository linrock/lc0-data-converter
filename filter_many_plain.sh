#!/bin/bash
# Filters positions out of .plain files concurrently

data_dir=/dev/shm

# remove all positions with castling flags
ls -1 $data_dir/*.plain | grep -v filtered | \
  xargs -P16 -I{} python3 filter_plain.py {}
