#!/bin/bash

EXEC_PATH=$PWD

mkdir -p ./ws_slam/src && cd ./ws_slam/src
git clone -b humble https://github.com/turtlebot/turtlebot4_robot.git
git clone -b humble https://github.com/turtlebot/turtlebot4.git
git clone -b humble https://github.com/turtlebot/turtlebot4_simulator.git

echo "!!!DONE!!!"
