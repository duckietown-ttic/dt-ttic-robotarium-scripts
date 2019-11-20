#!/bin/bash

source 0.env.sh

BAG_NAME=2019-11-19_18-23-18

# 1. fix unclosed bag
if [ -f ${DATA_DIR}/bags_in/${BAG_NAME}.bag.active ]; then
  docker run \
    -it \
    --rm \
    -v ${DATA_DIR}:/data \
    duckietown/dt-ros-commons:daffy-amd64 \
      rosbag reindex /data/bags_in/${BAG_NAME}.bag.active
  mv ${DATA_DIR}/bags_in/${BAG_NAME}.bag.active ${DATA_DIR}/bags_in/${BAG_NAME}.bag
fi

# 1. process bag
docker run \
  -it \
  --rm \
  -e INPUT_BAG_PATH=/data/bags_in/${BAG_NAME} \
  -e OUTPUT_BAG_PATH=/data/bags_out/${BAG_NAME} \
  -v ${DATA_DIR}:/data \
  --name post_processor \
  duckietown/post-processor:daffy-amd64-ttic
  # --net=host \
  # -e ROS_MASTER_URI=http://${LAB_ROS_MASTER_IP}:11311 \
