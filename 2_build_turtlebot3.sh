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


sudo apt update
sudo apt install -y dphys-swapfile

sudo dphys-swapfile swaoff

echo 'Modify CONF_SWASIZE=2048 in the /etc/dphys-swapfile'