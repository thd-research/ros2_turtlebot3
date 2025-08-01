# Base image
ARG from=ubuntu:24.04
FROM ${from}

LABEL maintainer="Cesar Gutierrez <cesar.gutierrez-marino@stud.th-deg.de>"

# Timezone Configuration
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ENV DEBIAN_FRONTEND=noninteractive

# Local install (en_US.UTF-8 locale)
RUN apt update && apt install -y locales \
    && locale-gen en_US en_US.UTF-8 \
    && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 \
    && export LANG=en_US.UTF-8

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    wget \
    curl \
    python3 \
    python3-pip \
    libssl-dev \
    libncurses5-dev \
    libsqlite3-dev \
    libreadline-dev \
    libffi-dev \
    uuid-dev \
    zlib1g-dev \
    lsb-release \
    gedit \
    unzip \
    gnupg2

# Install ROS 2 Jazzy and setup repositories correctly
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - \
    && echo "deb [arch=amd64] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/ros2-latest.list \
    && apt-get update \
    && apt-get install -y \
    ros-jazzy-desktop \
    ros-jazzy-ros-base \
    python3-argcomplete \
    python3-pip \
    python3-pytest-cov \
    python3-flake8 \
    python3-rosdep \
    python3-setuptools \
    libbullet-dev \
    python3-vcstool \
    python3-colcon-mixin \
    python3-colcon-common-extensions

# Configure colcon mixin
RUN colcon mixin add default https://raw.githubusercontent.com/colcon/colcon-mixin-repository/master/index.yaml && colcon mixin update default

# Installing Python3 components 
# RUN python3 -m pip install \
#     argcomplete \
#     flake8-blind-except \
#     flake8-builtins \
#     flake8-class-newline \
#     flake8-comprehensions \
#     flake8-deprecated \
#     flake8-docstrings \
#     flake8-import-order \
#     flake8-quotes \
#     pytest-repeat \
#     pytest-rerunfailures \
#     pytest
    
RUN apt-get install -y \
	g++ \
	clang \
	clang-format \
	libboost-all-dev \
	libeigen3-dev \
	libyaml-cpp-dev \
	libopencv-dev \
	libasio-dev \
	libtinyxml2-dev \
	qtbase5-dev \
	python3-empy \
	python3-pytest \
	python3-numpy

RUN apt update && apt install -y \
	  ros-jazzy-rclcpp \
	  ros-jazzy-moveit \
	  ros-jazzy-moveit-ros-control-interface

# # Install additional ROS 2 packages
# RUN apt-get install -y \
#     ros-jazzy-teleop-twist-joy \
#     ros-jazzy-teleop-twist-keyboard \
#     ros-jazzy-navigation2 \
#     ros-jazzy-gazebo-ros-pkgs \
#     ros-jazzy-eigen-stl-containers \
#     ros-jazzy-random-numbers \
#     ros-jazzy-moveit-common \
#     ros-jazzy-nav2-bringup

RUN apt-get update && apt-get install -y \
        ros-jazzy-turtlebot4-description \
        ros-jazzy-turtlebot4-msgs \
        ros-jazzy-turtlebot4-navigation \
        ros-jazzy-turtlebot4-node \
        ros-jazzy-irobot-create-nodes \
        ros-jazzy-turtlebot4-desktop

# install gazebo
RUN apt-get install -y curl
RUN curl https://packages.osrfoundation.org/gazebo.gpg --output /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null
RUN apt-get update
RUN apt-get install -y gz-harmonic

# Initialize rosdep
RUN rosdep init && rosdep update

RUN echo "source /opt/ros/jazzy/setup.bash" >> ~/.bashrc 
RUN echo 'export ROS_DOMAIN_ID=0 #TURTLEBOT4' >> ~/.bashrc
RUN echo 'source /usr/share/gazebo/setup.sh' >> ~/.bashrc

RUN echo "export ROS_DOMAIN_ID=0" >> ~/.bashrc
RUN echo "export RMW_IMPLEMENTATION=rmw_fastrtps_cpp" >> ~/.bashrc

#
#RUN apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /turtlebot4_ws

# Entry point: Open a bash shell with sourced ROS environment
#ENTRYPOINT ["/bin/bash", "-c", "source /opt/ros/humble/setup.bash && source ~/ws_moveit/install/setup.bash && exec bash"]
