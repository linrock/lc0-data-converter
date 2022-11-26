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

for pieces in ${common_5v2_7p[@]}; do
  wget $TB_URL/5v2_pawnful/$pieces.rtbw -O ../syzygy/7p/$pieces.rtbw
  wget $TB_URL/5v2_pawnful/$pieces.rtbz -O ../syzygy/7p/$pieces.rtbz
  echo $pieces
done
for pieces in ${common_4v3_7p[@]}; do
  wget $TB_URL/4v3_pawnful/$pieces.rtbw -O ../syzygy/7p/$pieces.rtbw
  wget $TB_URL/4v3_pawnful/$pieces.rtbz -O ../syzygy/7p/$pieces.rtbz
  echo $pieces
done
