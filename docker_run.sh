#!/bin/bash

# Run the container in the background (detached)
docker_container_id=$(docker run -d \
  --gpus all \
  --mount type=bind,source="$(pwd)"/../lc0-data,target=/root/lc0-data \
  --mount type=bind,source="$(pwd)"/../syzygy,target=/root/syzygy \
  --mount type=bind,source="$(pwd)"/../output-data,target=/root/output-data \
  lc0-rescorer)

# Attach a bash shell to the running container
docker exec -it $docker_container_id bash
