#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "robotiq_2f_gripper_interfaces::robotiq_2f_gripper_interfaces" for configuration "Release"
set_property(TARGET robotiq_2f_gripper_interfaces::robotiq_2f_gripper_interfaces APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(robotiq_2f_gripper_interfaces::robotiq_2f_gripper_interfaces PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/librobotiq_2f_gripper_interfaces.so"
  IMPORTED_SONAME_RELEASE "librobotiq_2f_gripper_interfaces.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS robotiq_2f_gripper_interfaces::robotiq_2f_gripper_interfaces )
list(APPEND _IMPORT_CHECK_FILES_FOR_robotiq_2f_gripper_interfaces::robotiq_2f_gripper_interfaces "${_IMPORT_PREFIX}/lib/librobotiq_2f_gripper_interfaces.so" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
