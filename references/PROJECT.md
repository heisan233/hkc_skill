# Project Reference

## Platform

- Ubuntu 22.04
- ROS 2 Humble
- Nav2
- Livox MID360
- FAST-LIO
- `global_localization_node`

## Navigation chain

```text
Livox MID360 + IMU
        |
        v
     FAST-LIO
        |
        v
    Odom / TF
        |
        v
Map + global localization
        |
        v
   Nav2 Planner
        |
        v
  Nav2 Controller
        |
        v
     /cmd_vel
        |
        v
   chassis control
```

## Map chain

```text
3D PCD
  |
  v
pointcloud_to_nav2_map
  |
  v
2D Nav2 map
  |
  v
map server
```

## Known project concerns

- ROS_DOMAIN_ID isolation between robots on the same LAN
- duplicate startup caused by background service plus manual launch
- TF continuity
- global localization initialization
- map replacement after moving to a new site
- unexpected `/cmd_vel` publisher count
- costmap `sensor origin out of bounds`

## Historical localization parameter references

These are historical project values, not universal recommended values:

```yaml
max_initialization_attempts: 100
threshold_fitness: 0.925
dis_updatemap: 1.0
max_online_translation_jump_m: 0.35
```

Do not propose changing these values until lower-layer prerequisites have been verified.
