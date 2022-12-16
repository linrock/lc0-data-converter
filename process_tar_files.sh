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
  db_003_binpack=$dirname.db003.binpack
  db_006_binpack=$dirname.db003.binpack
  no_db_binpack=$dirname.no-db.binpack
  if [ $(ls -1 $dirname.*.binpack | wc -l) -eq 3 ]; then
    echo Skipping $tarfile - 3 binpacks already exist
    return
  fi

  echo Extracting $tarfile ...
  tar xvf $filepath > /dev/null

  # rescore without using deblunder
  rescored_plain=$dirname.no-db.plain
  filtered_plain=$dirname.no-db.filtered.plain
  converted_binpack=$dirname.no-db.binpack
  rescorer rescore \
    --input=./$dirname \
    --syzygy-paths=/root/syzygy/345p:/root/syzygy/6p:/root/syzygy/7p \
    --no-delete-files \
    --nnue-plain-file=$rescored_plain \
    --nnue-best-score=true \
    --nnue-best-move=true \
    --deblunder=false \
    --threads=20
  python3 /root/filter_plain.py $rescored_plain
  stockfish convert $filtered_plain $converted_binpack validate
  ls -lth $converted_binpack
  if [ -f $converted_binpack ]; then
    rm $rescored_plain
    rm $filtered_plain
  else
    echo "Not removing .plain files since $converted_binpack doesn't exist"
  fi

  # rescore using deblunder Q blunder width 0.03
  rescored_plain=$dirname.db003.plain
  filtered_plain=$dirname.db003.filtered.plain
  converted_binpack=$dirname.db003.binpack
  rescorer rescore \
    --input=./$dirname \
    --syzygy-paths=/root/syzygy/345p:/root/syzygy/6p:/root/syzygy/7p \
    --no-delete-files \
    --nnue-plain-file=$rescored_plain \
    --nnue-best-score=true \
    --nnue-best-move=true \
    --deblunder=true \
    --deblunder-q-blunder-threshold=0.10 \
    --deblunder-q-blunder-width=0.03 \
    --threads=20
  python3 /root/filter_plain.py $rescored_plain
  stockfish convert $filtered_plain $converted_binpack validate
  ls -lth $converted_binpack
  if [ -f $converted_binpack ]; then
    rm $rescored_plain
    rm $filtered_plain
  else
    echo "Not removing .plain files since $converted_binpack doesn't exist"
  fi

  # rescore using deblunder Q blunder width 0.06
  rescored_plain=$dirname.db006.plain
  filtered_plain=$dirname.db006.filtered.plain
  converted_binpack=$dirname.db006.binpack
  rescorer rescore \
    --input=./$dirname \
    --syzygy-paths=/root/syzygy/345p:/root/syzygy/6p:/root/syzygy/7p \
    --no-delete-files \
    --nnue-plain-file=$rescored_plain \
    --nnue-best-score=true \
    --nnue-best-move=true \
    --deblunder=true \
    --deblunder-q-blunder-threshold=0.10 \
    --deblunder-q-blunder-width=0.06 \
    --threads=20
  python3 /root/filter_plain.py $rescored_plain
  stockfish convert $filtered_plain $converted_binpack validate
  ls -lth $converted_binpack
  if [ -f $converted_binpack ]; then
    rm $rescored_plain
    rm $filtered_plain
  else
    echo "Not removing .plain files since $converted_binpack doesn't exist"
  fi

  # Clean up directory and .tar file after processing is complete
  if [ $(ls -1 $dirname.*.binpack | wc -l) -eq 3 ]; then
    echo Finished converting $tarfile to 3 binpacks. Cleaning up.
    rm -rf $dirname
    rm $tarfile
  else
    echo Failed to convert $tarfile to 3 binpacks.
  fi
}
export -f process_tar_file

cd $1
ls -1v *.tar | xargs -P1 -I{} bash -c 'process_tar_file "$@"' _ {}
