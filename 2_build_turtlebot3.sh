sudo apt install -y python3-argcomplete python3-colcon-common-extensions libboost-system-dev build-essential
sudo apt install -y ros-humble-hls-lfcd-lds-driver
sudo apt install -y ros-humble-turtlebot3-msgs
sudo apt install -y ros-humble-dynamixel-sdk
sudo apt install -y ros-humble-xacro
sudo apt install -y libudev-dev

mkdir -p ~/turtlebot3_ws/src && cd ~/turtlebot3_ws/src

git clone -b humble https://github.com/ROBOTIS-GIT/turtlebot3.git ~/turtlebot3_ws/src/turtlebot3
git clone -b humble https://github.com/ROBOTIS-GIT/ld08_driver.git ~/turtlebot3_ws/src/ld08_driver
git clone -b humble https://github.com/ROBOTIS-GIT/coin_d4_driver.git ~/turtlebot3_ws/src/coin_d4_driver

cd ~/turtlebot3_ws/src/turtlebot3
rm -r turtlebot3_cartographer turtlebot3_navigation2
cd ~/turtlebot3_ws/

echo 'source /opt/ros/humble/setup.bash' >> ~/.bashrc
source ~/.bashrc
colcon build --symlink-install --parallel-workers 1
echo 'source ~/turtlebot3_ws/install/setup.bash' >> ~/.bashrc
source ~/.bashrc