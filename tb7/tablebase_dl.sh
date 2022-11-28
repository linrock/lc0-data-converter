#!/bin/bash

dl_dir1="/dev/shm"
dl_dir2="~/data/syzygy/7p"

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

eg_4v3_7p=(
KBBBvKQP
KBBBvKRR
KBBNvKQP
KBBNvKRR
KBBPPvKQ
KBBPvKBB
KBBPvKBN
KBBPvKNN
KBBPvKRB
KBBPvKRN
KBNNvKQP
KBNNvKRB
KBNNvKRR
KBNPPvKQ
KBNPvKBB
KBNPvKBN
KBNPvKNN
KBNPvKRB
KBNPvKRN
KBPPPvKR
KBPPvKBB
KBPPvKBN
KBPPvKBP
KBPPvKNN
KBPPvKNP
KBPPvKRP
KNNNvKQP
KNNNvKRB
KNNNvKRN
KNNNvKRR
KNNPPvKQ
KNNPvKBB
KNNPvKBN
KNNPvKNN
KNNPvKRB
KNNPvKRN
KNNPvKRP
KNPPPvKR
KNPPvKBN
KNPPvKBP
KNPPvKNN
KNPPvKNP
KNPPvKRP
KPPPPvKB
KPPPPvKN
KPPPPvKR
KPPPvKBP
KPPPvKNP
KPPPvKPP
KQBPvKQB
KQBPvKQN
KQBPvKQR
KQNNvKQR
KQNPvKQB
KQNPvKQN
KQNPvKQR
KQPPvKQB
KQPPvKQN
KQPPvKQP
KQPPvKRR
KQQPvKQQ
KQRBvKQQ
KQRNvKQQ
KQRPvKQR
KQRRvKQQ
KRBBvKQB
KRBBvKQN
KRBNvKQB
KRBNvKQN
KRBPPvKQ
KRBPvKQP
KRBPvKRB
KRBPvKRN
KRBPvKRR
KRNNvKQB
KRNNvKQN
KRNNvKQP
KRNNvKRR
KRNPPvKQ
KRNPvKQP
KRNPvKRB
KRNPvKRN
KRNPvKRR
KRPPPvKQ
KRPPvKBB
KRPPvKBN
KRPPvKNN
KRPPvKRB
KRPPvKRN
KRPPvKRP
KRRBvKQB
KRRBvKQN
KRRBvKQR
KRRNvKQB
KRRNvKQN
KRRNvKQR
KRRPvKQB
KRRPvKQN
KRRPvKQP
KRRPvKRR
KRRRvKQR
)

function download_tb_data() {
  pieces = $1  # KRBPvKQP, etc.
  for suffix in {rtbw,rtbz}; do
    tb_filename=$pieces.$suffix
    if [ ! -f $dl_dir1/$tb_filename ] && \
       [ ! -f $dl_dir2/$tb_filename ]; then
      if echo $pieces | grep -E 'K[QRBN]{4}v'; then
        subtype=5v2
      else if echo $pieces | grep -E 'K[QRBN]{3}v'; then
        subtype=4v3
      else
        subtype=6v1
      fi
      if echo $pieces | grep P; then
        subtype=${subtype}_pawnful
      else
        subtype=${subtype}_pawnless
      fi
      echo $tb_filename not found. Downloading ${subtype} ...
      wget $TB_URL/$tb_filename -O $dl_dir1/$tb_filename
    fi
  done
}

for pieces in ${eg_4v3_7p[@]}; do
  download_tb_data $pieces
done
