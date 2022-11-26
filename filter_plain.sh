#!/bin/bash
# Cleans .plain files so stockfish can convert these files later

data_dir=/dev/shm

# remove all positions with castling flags
ls -1 $data_dir/*.plain | grep -v filtered | \
  xargs -P4 -I{} python3 filter_no_castling.py {} {}.filtered.plain
