#!/bin/bash

# Clear the screen for a clean UI
clear

echo "------------------------------------------"
echo "      SCENARIO EXECUTION SELECTOR         "
echo "------------------------------------------"
echo "1) Straight (No Payload)"
echo "2) Turn (No Payload)"
echo "3) Cycle (No Payload)"
echo "4) Straight (Payload Back)"
echo "5) Turn (Payload Back)"
echo "6) Cycle (Payload Back)"
echo "------------------------------------------"

# Prompt the user for input
read -p "Enter your choice [1-6]: " choice

echo "" # Add a newline for readability

case $choice in
    1)
        echo "Executing: Straight - No Payload..."
        # Add your commands here
        ros2 bag record -o straight_no_payload /odom /cmd_vel
        ;;
    2)
        echo "Executing: Turn - No Payload..."
        # Add your commands here
        ros2 bag record -o turn_no_payload /odom /cmd_vel
        ;;
    3)
        echo "Executing: Cycle - No Payload..."
        # Add your commands here
        ros2 bag record -o cycle_no_payload /odom /cmd_vel
        ;;
    4)
        echo "Executing: Straight - Payload Back..."
        # Add your commands here
        ros2 bag record -o straight_payload_back /odom /cmd_vel
        ;;
    5)
        echo "Executing: Turn - Payload Back..."
        # Add your commands here
        ros2 bag record -o turn_payload_back /odom /cmd_vel
        ;;
    6)
        echo "Executing: Cycle - Payload Back..."
        # Add your commands here 
        ros2 bag record -o cycle_payload_back /odom /cmd_vel
        ;;
    *)
        echo "Error: Invalid selection. Please choose a number between 1 and 6."
        exit 1
        ;;
esac

echo "Task completed."