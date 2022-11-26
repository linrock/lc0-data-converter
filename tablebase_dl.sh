#!/bin/bash

TB_URL="https://tablebase.lichess.ovh/tables/standard/7/"

# practical 7-piece endgames:
# https://groups.google.com/g/fishcooking/c/chP0S4jXTxU
common_5v2_7p=(KBPPPvKB)
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

# 2-pawn endgames with material difference <= 1
eg_4v3_7p=(
  KQPPvKRR
  KNPPvKNP
  KPPPvKPP
  KBPPvKBP
  KNPPvKBP
  KRPPvKNN
  KBPPvKNN
  KRPPvKBB
  KRPPvKBN
  KRPPvKRP
  KBPPvKRP
  KNPPvKRP
  KQPPvKQP
)

function download_tb_data() {
  # $1 = url prefix, $2 = pieces
  if [ ! -f ../syzygy/7p/$2 ]; then
    echo $2
    wget $1/$2.rtbw -O ../syzygy/7p/$2.rtbw
    wget $1/$2.rtbz -O ../syzygy/7p/$2.rtbz
  fi
}

for pieces in ${common_5v2_7p[@]}; do
  download_tb_data $TB_URL/5v2_pawnful $pieces
done
for pieces in ${common_4v3_7p[@]}; do
  download_tb_data $TB_URL/4v3_pawnful $pieces
done
