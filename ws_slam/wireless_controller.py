import rclpy
from rclpy.node import Node

from sensor_msgs.msg import Joy
from geometry_msgs.msg import Twist


class ControllerSubcriber(Node):
    def __init__(self, node_name='controller_forward_subcriber'):
        super().__init__(node_name)
        
        self.subscription = self.create_subscription(
            Joy,
            'joy',
            self.listener_callback,
            10
        )

        self.publisher = self.create_publisher(
            Twist,
            'cmd_vel',
            0
        )

        self.linear_vel_scale = 0.22
        self.angular_vel_scale = 2.8
            
    def listener_callback(self, msg):
        self.get_logger().info(f"\rI heard a msg: {msg}")

        vel = Twist()
        vel.linear.x = msg.axes[1] * self.linear_vel_scale
        vel.angular.z = msg.axes[0] * self.angular_vel_scale

        self.publisher.publish(vel)
        

if __name__ == '__main__':
    rclpy.init()

    executor = rclpy.executors.SingleThreadedExecutor()

    laser_subcriber = ControllerSubcriber()
    rclpy.spin(laser_subcriber, executor=executor)
