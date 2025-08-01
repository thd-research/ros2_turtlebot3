if [ -f "cyclonedds_pc.xml" ]; then
    echo "cyclonedds_pc.xml exists."
else
    wget https://raw.githubusercontent.com/turtlebot/turtlebot4_setup/galactic/conf/cyclonedds_pc.xml
fi

sudo apt update
rosdep install --from-path src -yi
source /opt/ros/jazzy/setup.bash
colcon build --symlink-install

source /turtlebot4_ws/setup_env.sh
