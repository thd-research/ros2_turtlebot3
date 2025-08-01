#!/bin/bash

EXEC_PATH=$PWD

mkdir -p ./turtlebot4_ws/src && cd ./turtlebot4_ws/src
git clone -b jazzy https://github.com/turtlebot/turtlebot4_robot.git
git clone -b jazzy https://github.com/turtlebot/turtlebot4.git
git clone -b jazzy https://github.com/turtlebot/turtlebot4_simulator.git

echo "!!!DONE!!!"
