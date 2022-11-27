#!/bin/bash
# Converts filtered .plain files into .binpack files

ls -1 /dev/shm/*.filtered.plain | \
  xargs -P90 -I{} stockfish convert {} {}.binpack validate
