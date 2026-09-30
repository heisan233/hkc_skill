# Known Issues

## Case 1 — ROS 2 communication conflict on the same LAN

Symptom: nodes/topics from another robot appear and navigation behavior becomes unreliable.

Check:

```bash
echo $ROS_DOMAIN_ID
ros2 node list
ros2 topic list
```

Resolution direction: isolate robots with different ROS domain IDs and restart affected ROS 2 processes after confirmation.

## Case 2 — Global relocalization repeatedly fails

Check first:

1. LiDAR
2. IMU
3. FAST-LIO
4. TF
5. map
6. localization node

Only then inspect matching threshold, initialization attempts, initial pose error, and map quality.

## Case 3 — `/cmd_vel` publisher count is unexpectedly high

Possible causes:

- service and manual launch are both active
- duplicate navigation launch
- test control node still running
- another robot is visible because of ROS domain configuration

Check:

```bash
systemctl status nav-core.service
ros2 node list
ros2 topic info /cmd_vel
```

## Case 4 — Costmap reports `sensor origin out of bounds`

Inspect:

- `global_frame`
- `robot_base_frame`
- LiDAR TF
- sensor position
- costmap bounds

## Case 5 — New site is still using an old map

Inspect:

- PCD path
- Nav2 map YAML path
- launch arguments
- whether the displayed map matches the target site
