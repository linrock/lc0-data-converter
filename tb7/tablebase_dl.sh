#!/bin/bash

dl_dir1="~/data/syzygy/7p"
dl_dir2="~/data/syzygy/7p"

TB_URL="https://tablebase.lichess.ovh/tables/standard/7/"

tablebases_to_download=(
	KBBNvKQP
	KBBNvKRR
	KBBPPvKQ
	KBBPvKRB
	KBBPvKRN
	KBNNvKQP
	KBNNvKRR
	KBNPPvKQ
	KBNPvKBB
	KBNPvKRB
	KBNPvKRN
	KBPPvKRP
	KNNPPvKQ
	KNNPvKBB
	KNNPvKBN
	KNNPvKRN
	KNPPvKBP
	KNPPvKRP
	KPPPPvKB
	KPPPPvKN
	KQBPvKQR
	KQNPvKQB
	KQNPvKQR
	KQRBvKQQ
	KQRNvKQQ
	KRBBvKQB
	KRBBvKQN
	KRBNvKQB
	KRBNvKQN
	KRBPvKQP
	KRBPvKRR
	KRNNvKQN
	KRNPvKQP
	KRNPvKRB
	KRNPvKRR
	KRPPvKBB
	KRPPvKBN
	KRPPvKNN
	KRRBvKQR
	KRRNvKQB
	KRRNvKQR
)

function download_tb7_data() {
  pieces=$1  # KRBPvKQP, etc.
  for suffix in {rtbw,rtbz}; do
    tb_filename=$pieces.$suffix
    if [ -f $tb_filename ] || [ -f $tb_filename ]; then
      continue
    fi
    if echo $pieces | grep -E 'vK$' > /dev/null; then
      subtype=6v1
    elif echo $pieces | grep -E 'K[QRBNP]{4}v' > /dev/null; then
      subtype=5v2
    else
      subtype=4v3
    fi
    if echo $pieces | grep P > /dev/null; then
      subtype=${subtype}_pawnful
    else
      subtype=${subtype}_pawnless
    fi
    echo $tb_filename not found. Downloading ${subtype} ...
    echo $TB_URL/$subtype/$tb_filename
    wget $TB_URL/$subtype/$tb_filename # -O $dl_dir1/$tb_filename
  done
}

for pieces in ${tablebases_to_download[@]}; do
  download_tb7_data $pieces
done
