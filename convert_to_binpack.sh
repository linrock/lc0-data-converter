#!/bin/bash
# Merges filtered .plain files into a single .binpack

ls -1 /dev/shm/*.filtered.plain | \
  xargs -I{} stockfish convert {} T80.may2022.binpack append validate
