#!/bin/bash

source 0.env.sh

# process bag
docker run \
  -it \
  --rm \
  -e INPUT_BAG_PATH=/data/bags_in/${BAG_NAME} \
  -e OUTPUT_BAG_PATH=/data/bags_out/${BAG_NAME}.bag \
  -v ${DATA_DIR}:/data \
  -e ROS_MASTER_URI=http://${LAB_ROS_MASTER_IP}:11311 \
  --name post_processor \
  duckietown/post-processor:daffy-amd64
