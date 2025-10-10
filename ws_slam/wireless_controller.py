import rclpy
from rclpy.node import Node

from sensor_msgs.msg import Joy
from geometry_msgs.msg import Twist
from threading import Lock
import numpy as np


class PIDController:
    def __init__(self, Kp, Ki, Kd):
        self.Kp = Kp
        self.Ki = Ki
        self.Kd = Kd

        self.integral = 0.0
        self.prev_error = 0.0

    def update_setpoint(self, setpoint=0.0):
        self.setpoint = setpoint

    def update(self, measurement, dt):
        error = self.setpoint - measurement
        self.integral += error * dt
        derivative = (error - self.prev_error) / dt if dt > 0 else 0.0

        output = self.Kp * error + self.Ki * self.integral + self.Kd * derivative
        self.prev_error = error

        return output * dt

class ControllerSubcriber(Node):
    def __init__(self, node_name='controller_forward_subcriber'):
        super().__init__(node_name)
        
        self.subscription = self.create_subscription(
            Joy,
            'joy',
            self.listener_callback,
            1
        )

        self.publisher = self.create_publisher(
            Twist,
            'cmd_vel',
            10
        )

        self.linear_vel_scale = 0.22
        self.angular_vel_scale = 2.0

        self.vel = Twist()
        self.lock = Lock()

        self.target_vel = [0, 0]
        self.current_vel = [0, 0]

        self.create_timer(0.1, self.publish_vel)

        self.linear_pid = PIDController(Kp=8, Ki=0.0, Kd=0.0)
        self.angular_pid = PIDController(Kp=2, Ki=0.0, Kd=0.0)


    def publish_vel(self):
        # self.vel.linear.x = np.clip(self.target_vel[0], -self.linear_vel_scale, self.linear_vel_scale)
        # self.vel.angular.z = np.clip(self.target_vel[1], -self.angular_vel_scale, self.angular_vel_scale)

        self.current_vel[0] = self.linear_pid.update(self.current_vel[0], 0.1)
        self.current_vel[1] = self.angular_pid.update(self.current_vel[1], 0.1)

        self.vel.linear.x  = np.clip(self.current_vel[0], -self.linear_vel_scale, self.linear_vel_scale)
        self.vel.angular.z = np.clip(self.current_vel[1], -self.angular_vel_scale, self.angular_vel_scale)

        self.publisher.publish(self.vel)
        self.get_logger().info(f"publish a msg: {self.vel.linear} {self.vel.angular}")


    def listener_callback(self, msg):
        with self.lock:
            self.target_vel[0] = round((msg.axes[5] - 1) / -2 * self.linear_vel_scale, 2)

            if msg.buttons[4]:
                self.target_vel[0] *= -1

            self.target_vel[1] = round(msg.axes[0] * self.angular_vel_scale, 1)

            self.linear_pid.update_setpoint(self.target_vel[0])
            self.angular_pid.update_setpoint(self.target_vel[1])


if __name__ == '__main__':
    rclpy.init()

    executor = rclpy.executors.SingleThreadedExecutor()

    laser_subcriber = ControllerSubcriber()
    rclpy.spin(laser_subcriber, executor=executor)
