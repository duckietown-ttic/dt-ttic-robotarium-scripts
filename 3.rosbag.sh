#!/bin/bash

source 0.env.sh

# create bag
docker run \
  -it \
  --rm \
  --net=host \
  -v ${DATA_DIR}:/data \
  duckietown/dt-ros-commons:daffy-amd64 \
    rosbag record -a -O /data/bags_in/`date +%F_%H-%M-%S`.bag
