#!/bin/bash

# launch ros interface for overhead camera
docker run \
  -itd \
  --rm \
  --net=host \
  -v /data:/data \
  -e CONFIG_DIR=/data/config/nodes/ \
  -e PARAM_FILENAME=ttic \
  --name foscam \
  duckietown/dt-ttic-foscam-r2-interface:daffy-amd64

# launch apriltag detector on overhead camera
docker run \
  -itd \
  --rm \
  --net=host \
  --name atags \
  duckietown/dt-core:daffy-atags3-amd64 \
    roslaunch \
      duckietown_demos \
      generic_apriltag_detector.launch \
      image_topic:=/foscam_r2/camera_node/crop/rect/image \
      info_topic:=/foscam_r2/camera_node/crop/camera_info \
      camera_frame:=/foscam_r2/camera_optical_frame
