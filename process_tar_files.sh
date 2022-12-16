#!/bin/bash
# Takes lc0 .tar data files, rescores them with tablebases,
# converts them to .plain, filters out all positions with
# castling rights, them converts them to .binpack for stockfish
if [ "$#" -ne 1 ]; then
  echo "Usage: ./process_tar_files.sh <data_dir>"
  exit 0
fi

function rescore_tar_file() {
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
  python3 /root/filter_plain.py $dirname.plain
  stockfish convert $dirname.filtered.plain $dirname.binpack validate
}
export -f rescore_tar_file

cd $1
ls -1v *.tar | xargs -P1 -I{} bash -c 'rescore_tar_file "$@"' _ {}
