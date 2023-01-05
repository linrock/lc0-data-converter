#!/bin/bash
# Takes .binpack data files, removes all positions with castling flags from them,
# and outputs .binpack data file
if [ "$#" -ne 1 ]; then
  echo "Usage: ./remove_castling_flags.sh <data_dir>"
  exit 0
fi

function remove_castling_flags() {
  binpack_filepath=$1
  binpack_dirname=$(dirname $binpack_filepath)
  filename_prefix=$(basename $binpack_filepath .binpack)

  converted_plain=${binpack_dirname}/${filename_prefix}.plain
  stockfish convert $binpack_filepath $converted_plain
  python3 filter_plain.py $converted_plain
  rm $converted_plain
  stockfish convert \
    ${binpack_dirname}/${filename_prefix}.filtered.plain \
    ${binpack_dirname}/${filename_prefix}.no-castling.binpack
  rm ${binpack_dirname}/${filename_prefix}.filtered.plain
}
export -f remove_castling_flags

ls -1v $1/*.binpack | grep -v filtered | xargs -P10 -I{} bash -c 'remove_castling_flags "$@"' _ {}
