#!/bin/bash
# Takes lc0 .tar data files, rescores them with tablebases,
# and converts them to .plain for stockfish to process later
if [ "$#" -ne 1 ]; then
  echo "Usage: ./process_tar_files.sh <data_dir>"
  exit 0
fi

# Given a .tar data file, untar it, rescore it with bestmove and bestmove score,
# filter all positions with castling flags out of the .plain file, then convert
# it to a .binpack file.
function process_tar_file() {
  filepath=$1
  tarfile=$(basename $filepath)
  if date -r $tarfile | grep Dec; then
    echo Skipping $tarfile - not ready for processing yet
    return
  fi
  dirname=$(basename $tarfile .tar)
  if [ -f $dirname.binpack ]; then
    echo Skipping $tarfile - $dirname.binpack already exists
    return
  fi

  echo Extracting $tarfile ...
  tar xvf $filepath > /dev/null

  rescored_plain=$dirname.plain
  rescorer rescore \
    --input=./$dirname \
    --syzygy-paths=/root/syzygy/345p:/root/syzygy/6p:/root/syzygy/7p \
    --nnue-plain-file=$rescored_plain \
    --nnue-best-score=true \
    --nnue-best-move=true \
    --threads=20

  rm -rf $dirname
  python3 /root/filter_plain.py $rescored_plain
  stockfish convert $dirname.filtered.plain $dirname.binpack validate
  ls -lth $dirname.binpack

  if [ -f $dirname.binpack ]; then
    rm $rescored_plain
    rm $dirname.filtered.plain
  else
    echo "Not removing .plain files since $dirname.binpack doesn't exist"
  fi
  # TODO remove .tar file after making sure to avoid redownloading it
}
export -f process_tar_file

cd $1
ls -1v *.tar | xargs -P1 -I{} bash -c 'process_tar_file "$@"' _ {}
