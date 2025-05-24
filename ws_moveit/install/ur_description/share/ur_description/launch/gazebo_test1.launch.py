from launch import LaunchDescription
from launch.actions import DeclareLaunchArgument, IncludeLaunchDescription, TimerAction
from launch.substitutions import (
    LaunchConfiguration,
    PathJoinSubstitution,
    Command,
    FindExecutable,
)
from launch_ros.actions import Node
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch_ros.parameter_descriptions import ParameterValue
from ament_index_python.packages import get_package_share_directory
import os


def generate_launch_description():
    # === Argumentos de usuario ===
    use_sim_time = LaunchConfiguration("use_sim_time")
    ur_type = LaunchConfiguration("ur_type")
    robot_name = LaunchConfiguration("name")

    # === Paquete y archivo Xacro ===
    description_package = "ur_description"
    urdf_file = "ur.urdf.xacro"

    # === Declarar argumentos de launch ===
    declare_args = [
        DeclareLaunchArgument("use_sim_time", default_value="true"),
        DeclareLaunchArgument("ur_type", default_value="ur3e"),
        DeclareLaunchArgument("name", default_value="ur"),
    ]

    # === Ejecutar xacro y generar robot_description como string ===
    robot_description_content = Command(
        [
            PathJoinSubstitution([FindExecutable(name="xacro")]),
            " ",
            PathJoinSubstitution(
                [get_package_share_directory(description_package), "urdf", urdf_file]
            ),
            " name:=", robot_name,
            " ur_type:=", ur_type,
            " sim_gazebo:=true",
        ]
    )

    robot_description = {
        "robot_description": ParameterValue(robot_description_content, value_type=str)
    }

    # === Lanzamiento de Gazebo (servidor + cliente) ===
    gazebo_launch = IncludeLaunchDescription(
        PythonLaunchDescriptionSource(
            [
                os.path.join(
                    get_package_share_directory("gazebo_ros"), "launch", "gazebo.launch.py"
                )
            ]
        )
    )

    # === Nodos esenciales ===
    joint_state_pub = Node(
        package="joint_state_publisher",
        executable="joint_state_publisher",
        name="joint_state_publisher",
    )

    robot_state_pub = Node(
        package="robot_state_publisher",
        executable="robot_state_publisher",
        name="robot_state_publisher",
        parameters=[robot_description, {"use_sim_time": use_sim_time}],
    )

    spawn_robot = Node(
        package="gazebo_ros",
        executable="spawn_entity.py",
        arguments=["-topic", "robot_description", "-entity", robot_name],
        output="screen",
    )

    # === Spawners de controladores ===
    spawner_joint_state = Node(
        package="controller_manager",
        executable="spawner",
        arguments=["joint_state_broadcaster"],
        output="screen",
    )

    spawner_arm_controller = Node(
        package="controller_manager",
        executable="spawner",
        arguments=["ur_arm_controller"],
        output="screen",
    )

    # Espera a que controller_manager se inicie
    controller_spawners = TimerAction(
        period=3.0, actions=[spawner_joint_state, spawner_arm_controller]
    )

    # === Ensamblar LaunchDescription ===
    return LaunchDescription(
        declare_args
        + [
            gazebo_launch,
            joint_state_pub,
            robot_state_pub,
            spawn_robot,
            controller_spawners,
        ]
    )

