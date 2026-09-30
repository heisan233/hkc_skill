# Read-only Troubleshooting Commands

## ROS domain and graph

```bash
echo $ROS_DOMAIN_ID
ros2 node list
ros2 topic list
```

## `/cmd_vel`

```bash
ros2 topic info /cmd_vel
ros2 topic echo /cmd_vel
```

## Topic frequency

```bash
ros2 topic hz <topic_name>
```

## Localization parameters

```bash
ros2 param list /global_localization_node
ros2 param get /global_localization_node <parameter_name>
```

## TF

```bash
ros2 run tf2_ros tf2_echo odom base_footprint
```

If deployed with `base_link`:

```bash
ros2 run tf2_ros tf2_echo odom base_link
```

Generate a TF report:

```bash
ros2 run tf2_tools view_frames
```

## Navigation service

```bash
systemctl status nav-core.service
journalctl -u nav-core.service
```

These checks are intended to collect state. Do not restart services, kill processes, or modify files without explicit confirmation.
