# Install the required packages on the Raspberry Pi in order to upload the OpenCR firmware.
sudo dpkg --add-architecture armhf
sudo apt-get update
sudo apt-get install libc6:armhf

# Depending on your specific model, specify either burger or waffle for the OPENCR_MODEL name.
export OPENCR_PORT=/dev/ttyACM0  
export OPENCR_MODEL=burger
rm -rf ./opencr_update.tar.bz2  

# Download the firmware and required loader, then extract the file to prepare for upload. [TurtleBot3 SBC] 
wget https://github.com/ROBOTIS-GIT/OpenCR-Binaries/raw/master/turtlebot3/ROS2/latest/opencr_update.tar.bz2
tar -xvf opencr_update.tar.bz2 

# Upload firmware to the OpenCR.
cd ./opencr_update  
./update.sh $OPENCR_PORT $OPENCR_MODEL.opencr  