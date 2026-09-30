# Decision Rules

## NAV-COM-001 — Cross-robot communication

IF nodes or topics from another robot are visible on the same LAN  
THEN check `ROS_DOMAIN_ID` isolation before debugging Nav2 behavior.

## NAV-START-001 — Duplicate startup

IF the navigation system is already running as a service and a second manual launch is started  
THEN check for duplicate nodes, topics, and `/cmd_vel` publishers.

## NAV-NODE-001 — Missing required node

IF a required navigation node is absent  
THEN inspect launch/service startup and crash logs before changing node parameters.

## NAV-TOPIC-001 — Missing map

IF `/map` is absent  
THEN inspect map path, map server, and launch configuration.  
STOP planner diagnosis until the map is restored.

## NAV-TOPIC-002 — Abnormal cmd_vel publishers

IF `/cmd_vel` publisher count differs significantly from the known-good baseline  
THEN check duplicate navigation instances, test teleop/control nodes, and ROS domain isolation.

## NAV-TF-001 — Broken base transform

IF `odom -> base_footprint` or the deployed equivalent cannot be resolved  
THEN enter TF diagnosis.  
STOP localization, planner, and controller tuning.

## NAV-SENSOR-001 — Missing LiDAR stream

IF LiDAR data is absent or not continuous  
THEN inspect the Livox driver, device/network connection, and timestamping.  
STOP higher-layer navigation diagnosis.

## NAV-MAP-001 — Wrong map

IF a map is visible but clearly does not match the site  
THEN verify PCD, YAML, and launch map paths before tuning localization.

## NAV-LOC-001 — Localization failure

IF localization fails  
THEN verify communication, LiDAR/IMU, FAST-LIO, TF, map, and localization node state in that order.  
Only after those pass should localization parameters be analyzed.

## NAV-PLAN-001 — Localized but no path

IF localization is healthy and a goal is accepted but no global path appears  
THEN inspect planner server, global costmap, goal validity, and obstacle/inflation state.

## NAV-CTRL-001 — Path exists but no velocity

IF a global path exists but `/cmd_vel` remains zero  
THEN inspect controller server, local costmap, goal checker, and safety restrictions.

## NAV-CTRL-002 — Velocity exists but chassis does not move

IF `/cmd_vel` contains normal motion commands but the chassis remains stationary  
THEN stop prioritizing Nav2 and transfer diagnosis to the chassis/control layer.

## NAV-COSTMAP-001 — Sensor origin out of bounds

IF logs contain `sensor origin out of bounds`  
THEN inspect `global_frame`, `robot_base_frame`, sensor TF, sensor origin, and costmap bounds.
