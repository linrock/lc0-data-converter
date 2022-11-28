#!/bin/bash
if [ "$#" -ne 1 ]; then
  echo "Usage: ./convert_to_binpack.sh <data_dir>"
  exit 0
fi

# Converts filtered .plain files into .binpack files
ls -1 $1/*.filtered.plain | \
  xargs -P90 -I{} stockfish convert {} {}.binpack validate
