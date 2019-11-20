#!/bin/bash

source 0.env.sh

BAG_NAME=2019-11-19_18-23-18

docker run \
  -it \
  --rm \
  -e ATMSGS_BAG=/data/bags_out/${BAG_NAME}.bag \
  -e OUTPUT_DIR=/data/trajectories \
  -e ROS_MASTER=box2 \
  -e ROS_MASTER_IP=${LAB_ROS_MASTER_IP} \
  -e DUCKIETOWN_WORLD_FORK=duckietown-ttic \
  -e MAP_NAME=TTIC_ripltown \
  -v ${DATA_DIR}:/data \
  --name graph_optimizer \
  duckietown/cslam-graphoptimizer:daffy-amd64

mkdir -p ${DATA_DIR}/trajectories/${BAG_NAME}
mv ${DATA_DIR}/autobot*.yaml ${DATA_DIR}/trajectories/${BAG_NAME}/
