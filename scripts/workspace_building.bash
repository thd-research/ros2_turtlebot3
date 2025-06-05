#!/bin/bash

EXEC_PATH=$PWD

mkdir -p ./ws_slam/src && cd ./ws_slam/src
#git clone -b humble https://github.com/moveit/moveit2_tutorials
#git clone -b humble https://github.com/SteveMacenski/slam_toolbox.git
git clone -b humble https://github.com/ROBOTIS-GIT/turtlebot3_simulations.git
git clone -b humble https://github.com/ROBOTIS-GIT/DynamixelSDK.git
git clone -b humble https://github.com/ROBOTIS-GIT/turtlebot3_msgs.git
git clone -b humble https://github.com/ROBOTIS-GIT/turtlebot3.git

echo "!!!DONE!!!"
