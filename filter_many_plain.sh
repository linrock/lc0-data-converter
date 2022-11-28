#!/bin/bash
if [ "$#" -ne 1 ]; then
  echo "Usage: ./filter_many_plain.sh <data_dir>"
  exit 0
fi

# Filters positions out of .plain files concurrently
ls -1 $1/*.plain | grep -v filtered | \
  xargs -P16 -I{} python3 filter_plain.py {}
