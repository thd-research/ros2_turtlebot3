source /opt/ros/humble/setup.bash
source /ws_slam/install/setup.sh

# export RMW_IMPLEMENTATION=rmw_fastrtps_cpp 
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
export ROS_DOMAIN_ID=55

export CYCLONEDDS_URI=/ws_slam/cyclonedds_rpi.xml
