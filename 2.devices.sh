#!/bin/bash

source 0.env.sh

# make sure the acquisition-bridge is running on all the devices

# 1. create container (watchtower)
brun \
  -f w:r:01,$(($NUM_WATCHTOWERS + 1)) \
  -I \
  -- \
    docker \
      -H watchtower{w}.local \
      run \
        -dit \
        --restart unless-stopped \
        --net=host \
        -e ROBOT_TYPE=watchtower \
        -e LAB_ROS_MASTER_IP=${LAB_ROS_MASTER_IP} \
        --name acquisition-bridge \
        duckietown/acquisition-bridge:daffy-arm32v7


# 2. run container (watchtower)
brun \
  -f w:r:01,$(($NUM_WATCHTOWERS + 1)) \
  -- \
    docker \
      -H watchtower{w}.local \
      start acquisition-bridge

# 3. create container (watchtower)
brun \
  -f b:r:01,$(($NUM_DUCKIEBOTS + 1)) \
  -I \
  -- \
    docker \
      -H autobot{b}.local \
      run \
        -dit \
        --restart unless-stopped \
        --net=host \
        -e LAB_ROS_MASTER_IP=${LAB_ROS_MASTER_IP} \
        -v /data:/data \
        --name acquisition-bridge \
        duckietown/acquisition-bridge:daffy-arm32v7

# 4. create container (watchtower)
brun \
  -f b:r:01,$(($NUM_DUCKIEBOTS + 1)) \
  -- \
    docker \
      -H autobot{b}.local \
      start acquisition-bridge
