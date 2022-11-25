#!/bin/bash

common_5v2_7p=(
  KBPPPvKB
)
common_4v3_7p=(
  KBPPvKBP
  KBPPvKNP
  KNPPvKBP
  KNPPvKNP
  KPPPvKBP
  KPPPvKPP
  KQPPvKQP
  KRPPvKRP
)
for pieces in ${common_5v2_7p[@]}; do
  wget https://tablebase.lichess.ovh/tables/standard/7/5v2_pawnful/$pieces.rtbw \
    -O ../syzygy/7p/$pieces.rtbw
  wget https://tablebase.lichess.ovh/tables/standard/7/5v2_pawnful/$pieces.rtbz \
    -O ../syzygy/7p/$pieces.rtbz
  echo $pieces
done
for pieces in ${common_4v3_7p[@]}; do
  wget https://tablebase.lichess.ovh/tables/standard/7/4v3_pawnful/$pieces.rtbw \
    -O ../syzygy/7p/$pieces.rtbw
  wget https://tablebase.lichess.ovh/tables/standard/7/4v3_pawnful/$pieces.rtbz \
    -O ../syzygy/7p/$pieces.rtbz
  echo $pieces
done
