#!/bin/bash

set -e

distro=`lsb_release -r | awk '{ print $2 }'`
[ "$distro" = "18.04" ] && ROS_DISTRO="melodic"
[ "$distro" = "20.04" ] && ROS_DISTRO="noetic"

echo "Starting catkin test build"
cd ~/uav_ws/src
source /opt/ros/$ROS_DISTRO/setup.bash
catkin build
echo "Ended catkin test build"

echo "Starting arducopter build"
cd ~/uav_ws/src/uav_ros_simulation/.gitman/ardupilot
export PATH="/usr/lib/ccache:$PATH"
export PATH="/opt/gcc-arm-none-eabi-6-2017-q2-update/bin:$PATH"
modules/waf/waf-light configure --board sitl                    
modules/waf/waf-light build --target bin/arducopter
echo "Ending arducopter build"