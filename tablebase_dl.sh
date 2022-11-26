#!/bin/bash

DL_DIR="../data/syzygy/7p"
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

function download_tb_data() {  # $1 = url_prefix, $2 = pieces
  for suffix in {rtbw,rtbz}; do
    tb_filename=$2.$suffix
    if [ ! -f $DL_DIR/$tb_filename ]; then
      echo $tb_filename not found. Downloading...
      wget $1/$tb_filename -O $DL_DIR/$tb_filename
    fi
  done
}

for pieces in ${common_5v2_7p[@]}; do
  download_tb_data $TB_URL/5v2_pawnful $pieces
done
for pieces in ${eg_4v3_7p[@]}; do
  download_tb_data $TB_URL/4v3_pawnful $pieces
done
