#!/bin/bash

# Run the container in the background (detached)
docker_container_id=$(docker run -d \
  --mount type=bind,source="$(pwd)"/../data,target=/root/data \
  --mount type=bind,source="$(pwd)"/../syzygy,target=/root/syzygy \
  lc0-converter)

# Attach a bash shell to the running container
docker exec -it $docker_container_id bash
