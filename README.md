## Docker Scripts for TurtleBot3 SLAM (ROS 2 Humble)

This repository contains Docker scripts to simplify the setup and execution of a SLAM development environment for TurtleBot3 using **ROS 2 Humble**.
The goal is to create a learning environment for THD robotics team students to explore, practice, and understand SLAM concepts.

##  Installation and Usage

These scripts automate Docker installation, image building, and container execution.

##: It is recommended to use the `-n` flag to enable Nvidia GPU support (if available).

```bash
bash install_docker.sh -n       # (Re)install Docker with Nvidia support
bash build_docker.sh -n         # Build the Docker image
bash run_docker.sh -n           # Run the Docker container
bash into_docker.sh             # Access the running Docker container##

## Based On
Official TurtleBot3 SLAM documentation:
https://emanual.robotis.com/docs/en/platform/turtlebot3/slam/

SLAM Toolbox repository (Humble branch):
https://github.com/SteveMacenski/slam_toolbox/tree/humble

## Included Packages (from source)
Inside the container workspace (./ws_slam/src), the following packages are cloned from their official sources:

turtlebot3_simulations

DynamixelSDK

turtlebot3_msgs

turtlebot3

(You can uncomment the slam_toolbox line in the script to clone it as well)

## Notes
This setup is intended for simulation and SLAM testing in ROS 2 Humble.

Modify the scripts as needed to adapt to your GPU, host system, or workspace preferences.

