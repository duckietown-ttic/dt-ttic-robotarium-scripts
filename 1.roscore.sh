#!/bin/bash

source 0.env.sh

# launch roscore
docker run \
  -dit \
  --rm \
  --net=host \
  -v ${DATA_DIR}:/data \
  --name roscore \
  duckietown/dt-ros-commons:daffy-amd64 \
    roscore
