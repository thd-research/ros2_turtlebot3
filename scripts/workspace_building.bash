#!/bin/bash

EXEC_PATH=$PWD

mkdir -p ./test3/src && cd ./test3/src
git clone -b humble https://github.com/moveit/moveit2_tutorials

cd $EXEC_PATH

cp scripts/build.bash ./test3/
#cp -r ../rcognita ../turtlebot3_ws/src/
echo "!!!DONE!!!"
