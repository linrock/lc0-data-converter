# lc0 data converter

Converts lc0 training data to binpack files for Stockfish NNUE training.


### Downloading tablebases

https://tablebase.lichess.ovh/tables/standard/

Example of how to download 3,4,5,6-piece Syzygy tablebases

```bash
wget --mirror --no-parent --no-directories -e robots=off \
  https://tablebase.lichess.ovh/tables/standard/3-4-5-dtz-nr/
wget --mirror --no-parent --no-directories -e robots=off \
  https://tablebase.lichess.ovh/tables/standard/6-dtz/
wget --mirror --no-parent --no-directories -e robots=off \
  https://tablebase.lichess.ovh/tables/standard/6-wdl/
```

List of common 7-piece tablebase positions ([source](https://groups.google.com/g/fishcooking/c/chP0S4jXTxU))

KBPPPvKB
KBPPvKBP
KBPPvKNP
KNPPvKBP
KNPPvKNP
KPPPvKBP
KPPPvKPP
KQPPvKQP
KRPPvKRP

### Resources

https://github.com/glinscott/nnue-pytorch/wiki/Training-datasets
https://storage.lczero.org/files/training_data/test80/
https://tablebase.lichess.ovh/tables/standard/
https://github.com/Tilps/lc0/tree/rescore_tb
https://github.com/official-stockfish/Stockfish/blob/tools/docs/convert.md
