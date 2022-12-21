# LC0 data converter

Linux container environment for converting raw LC0 training data to .binpack files for training Stockfish NNUE. This provides tools to:

* Download LC0 training data
* Download Syzygy endgame tablebases
* Rescore LC0 data with tablebases and output .plain data files
* Filter positions out of .plain files that Stockfish can't use for training
* Convert .plain -> .binpack files usable for training Stockfish NNUE


### Usage

A docker image can be used to create a linux container environment with all dependencies installed:

```
sudo apt install docker.io
./docker_build.sh
./docker_run.sh
```

Use `lc0_data_downloader.sh` to download training data. Convert the training data either by:

A sequence of
- `rescore_tar_files.sh` to use the lc0 rescorer tool to convert tar data files to .plain
- `filter_many_plain.sh` to filter positions out of the converted .plain files
- `convert_to_binpack` to convert plain files into binpack data files

Converting .tar files to .binpacks and deleting the .tar files afterwards
- `process_tar_files.sh`


### Downloading tablebases

https://tablebase.lichess.ovh/tables/standard/

Example of how to download 3,4,5,6-piece Syzygy tablebases

```bash
wget --mirror --no-parent --no-directories -e robots=off \
  https://tablebase.lichess.ovh/tables/standard/3-4-5/
wget --mirror --no-parent --no-directories -e robots=off \
  https://tablebase.lichess.ovh/tables/standard/6-dtz/
wget --mirror --no-parent --no-directories -e robots=off \
  https://tablebase.lichess.ovh/tables/standard/6-wdl/
```

List of common 7-piece tablebase positions ([source](https://groups.google.com/g/fishcooking/c/chP0S4jXTxU))

- KBPPPvKB
- KBPPvKBP
- KBPPvKNP
- KNPPvKBP
- KNPPvKNP
- KPPPvKBP
- KPPPvKPP
- KQPPvKQP
- KRPPvKRP


### Resources

- https://github.com/glinscott/nnue-pytorch/wiki/Training-datasets
- https://github.com/Tilps/lc0/tree/rescore_tb
- https://tablebase.lichess.ovh/tables/standard/
- https://github.com/official-stockfish/Stockfish/blob/tools/docs/convert.md
- https://lczero.org/dev/wiki/project-history/
- https://storage.lczero.org/files/training_data/test80/
