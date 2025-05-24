#!/bin/bash

EXEC_PATH=$PWD

mkdir -p ./ws_moveit/src && cd ./ws_moveit/src
#git clone -b humble https://github.com/moveit/moveit2_tutorials
git clone https://github.com/jannishaberhausen/robotiq_2f_gripper_ros2.git
git clone -b humble https://github.com/UniversalRobots/Universal_Robots_ROS2_Description.git
git clone -b humble https://github.com/UniversalRobots/Universal_Robots_ROS2_Gazebo_Simulation.git
git clone -b humble https://github.com/UniversalRobots/Universal_Robots_ROS2_Driver.git

# Inicializar submódulos del gripper
cd robotiq_2f_gripper_ros2
git submodule update --init --recursive

# Regresar al directorio src
#cd ..

# Importar repositorios adicionales definidos en moveit2_tutorials
#vcs import --recursive < moveit2_tutorials/moveit2_tutorials.repos
#
## Volver al workspace root
#cd ..
#
## Instalar dependencias del workspace usando rosdep
#sudo apt update
#rosdep update
#rosdep install -r --from-paths . --ignore-src --rosdistro humble -y
#cp -r ../rcognita ../turtlebot3_ws/src/
echo "!!!DONE!!!"
