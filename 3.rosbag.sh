#!/bin/bash

source 0.env.sh

BAG_NAME=`date +%F_%H-%M-%S`

# 1. create bag
docker run \
  -it \
  --rm \
  --net=host \
  -v ${DATA_DIR}:/data \
  duckietown/dt-ros-commons:daffy-amd64 \
    rosbag record -a -O /data/bags_in/${BAG_NAME}.bag

# 2. fix unclosed bag
if [ -f ${DATA_DIR}/bags_in/${BAG_NAME}.bag.active ]; then
  docker run \
    -it \
    --rm \
    -v ${DATA_DIR}:/data \
    duckietown/dt-ros-commons:daffy-amd64 \
      rosbag reindex /data/bags_in/${BAG_NAME}.bag.active
  mv ${DATA_DIR}/bags_in/${BAG_NAME}.bag.active ${DATA_DIR}/bags_in/${BAG_NAME}.bag
  rm -f ${DATA_DIR}/bags_in/${BAG_NAME}.bag.orig.active
fi

# 3. print out info
echo "The bag name is ${BAG_NAME}"
