## After reinstall ROS2 on turtlebot3 waffle, OpenManipulator cannot be controlled anymore.

[ERROR] [DynamixelSDKWrapper] [TxRxResult] There is no status packet!

### Solution
1. Download Arduino IDE and follow from step1 to step8 in this setup https://emanual.robotis.com/docs/en/platform/turtlebot3/manipulation/#arduino-ide
2. Download Dynamixel Wizard 2.0
3. Connect OpenCR board to PC via microUSB-USBA cable. 
    - Unplug microUSB-USBA connection to RaspberryPi and use USB-extension cable to connect it to PC
4. Transform OpenCR to an adaptor: Upload Firmware to OpenCR using: Arduino `Examples/OpenCR/10.Etc/usb_to_dxl`
5. On `Dynamixel Wizard 2.0`: Check scan `Options`: 
-   Choose `/dev/ttyACM0` Virtual ComPort
-   Choose `1 Mbps` baudrate
-   Choose `protocol 1`
-   Choose ID range from 10 to 20

6. After connecting to all the servos, update the latest Firmware.
7. Change `Return Delay Time` to 0 and Click `Save` button. (Make sure torch control is disable)
8. Disconnect from all the Servo
9. Upload new Firmware for Manipulator using Arduino `Examples/Turtlebot3 ROS2/turtlebot3_manipulation`
10. Reconnect microUSB-USBA cable to The RaspberryPi.
11. Run Bringup command.