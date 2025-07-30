sudo apt update
rosdep install --from-path src -yi
source /opt/ros/humble/setup.bash
colcon build --symlink-install

source /opt/ros/humble/setup.bash
export RMW_IMPLEMENTATION=rmw_fastrtps_cpp
export ROS_DOMAIN_ID=0