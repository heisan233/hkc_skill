# Navigation Troubleshooting Workflow

## 1. Communication

Check the current ROS domain and discovered graph.

```bash
echo $ROS_DOMAIN_ID
ros2 node list
ros2 topic list
```

If nodes or topics from another robot are visible, investigate ROS_DOMAIN_ID isolation before continuing.

## 2. Nodes

Confirm the expected navigation-related nodes are running.

If a required node is missing, inspect the launch process, shell startup script, service state, and crash logs before tuning parameters.

## 3. Topics

Prioritize:

- `/map`
- `/tf`
- `/tf_static`
- `/odom`
- `/cmd_vel`
- LiDAR point cloud topic
- IMU topic

If a required topic is missing, identify the node that should publish it.

## 4. TF

Check the transform from `odom` to the robot base frame.

Typical check:

```bash
ros2 run tf2_ros tf2_echo odom base_footprint
```

If the deployed configuration uses `base_link`, check that frame instead.

A broken TF chain blocks localization and Nav2 analysis.

## 5. Livox / IMU / FAST-LIO

Confirm:

- Livox MID360 data is continuously available
- IMU data is available
- FAST-LIO produces expected odometry / transform output
- point cloud motion in RViz is consistent with chassis motion

If the sensor chain is unhealthy, resolve it before map matching or Nav2 tuning.

## 6. Map

Confirm:

- the loaded map belongs to the current site
- the configured PCD / Nav2 map paths are correct
- `/map` is published
- the map approximately matches the physical environment

For a newly deployed site, explicitly check that an older map was not left in the launch configuration.

## 7. Global localization

Only analyze localization parameters after communication, sensors, TF, and map are healthy.

Then inspect:

- initialization attempts
- matching quality / fitness
- initial pose error
- map quality
- whether the environment has enough geometric features

## 8. Planner

If localization is healthy but no global path is produced, inspect:

- planner server
- global costmap
- whether the goal is in an obstacle or unknown area
- map obstacles and inflation

## 9. Controller

If a path exists but the robot does not move, inspect `/cmd_vel`.

- If `/cmd_vel` remains zero, inspect controller, local costmap, goal checker, and safety restrictions.
- If `/cmd_vel` is normal but the chassis does not move, transfer diagnosis to the chassis/control layer.

## 10. Closeout

Summarize:

- where the failure was localized
- what was verified
- what remains uncertain
- the next action
- how to verify recovery
