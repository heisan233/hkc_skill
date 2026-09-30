---
name: inspection-chassis-navigation-troubleshooting
description: Diagnose ROS 2 Humble inspection-chassis navigation problems involving ROS_DOMAIN_ID communication, nodes, topics, TF, Livox MID360/FAST-LIO, maps, global localization, Nav2 planning, controller behavior, and cmd_vel. Use when the user reports navigation startup failures, localization failures, missing paths, abnormal ROS 2 communication, map/TF issues, or a robot that has a path but does not move.
compatibility: Designed for a ROS 2 Humble inspection chassis using Nav2, Livox MID360 and FAST-LIO. Shell execution is optional; the skill can also guide a human operator through the same read-only checks.
metadata:
  version: "1.0"
  project: "HKC inspection chassis navigation"
---

# Inspection Chassis Navigation Troubleshooting

Use this skill to troubleshoot the inspection chassis navigation stack in a fixed, layered order.

## Core principle

Diagnose from lower layers to higher layers:

**communication -> nodes -> topics -> TF -> sensors/FAST-LIO -> map -> localization -> planner -> controller -> chassis**

Do not recommend changing upper-layer parameters while a lower-layer prerequisite is failing.

Examples:

- If TF is broken, do not start by tuning localization or Nav2 planner parameters.
- If the map is missing or wrong, do not continue with planner tuning.
- If `/cmd_vel` is being produced normally but the robot does not move, stop prioritizing Nav2 and move to the chassis/control layer.

## Workflow

1. Classify the symptom:
   - startup failure
   - communication conflict
   - sensor or FAST-LIO issue
   - TF issue
   - map issue
   - localization failure
   - planning failure
   - path exists but robot does not move

2. If the user's description is incomplete, ask only for the minimum missing state:
   - Does the navigation program start?
   - Is the map visible in RViz?
   - Is live point cloud data visible?
   - Is localization successful?
   - Is a global path generated after sending a goal?
   - Does `/cmd_vel` contain non-zero output?

3. Follow the detailed procedure in [references/WORKFLOW.md](references/WORKFLOW.md).

4. Apply the decision rules in [references/RULES.md](references/RULES.md).

5. Use the project baseline in [references/PROJECT.md](references/PROJECT.md) and known cases in [references/KNOWN_ISSUES.md](references/KNOWN_ISSUES.md).

6. Use commands from [references/COMMANDS.md](references/COMMANDS.md). If shell execution is available, prefer the read-only helper script:
   `scripts/collect_navigation_snapshot.sh`

7. Return the result using [assets/diagnosis-report.md](assets/diagnosis-report.md).

## Modification policy

Read-only inspection may be performed directly when the host agent permits it.

Before recommending or performing any of the following, show the reason and ask for confirmation:

- changing `ROS_DOMAIN_ID`
- editing YAML or launch files
- editing localization or Nav2 parameters
- restarting system services
- killing navigation processes
- replacing map files

For a proposed change, state:

- current value or state, if known
- proposed value or action
- reason
- verification method
- rollback method

## Stop conditions

Stop higher-layer diagnosis and report the blocking layer when any of these conditions is found:

- LiDAR data is missing
- the required TF chain is unavailable
- the map is not loaded or is clearly the wrong environment
- `/cmd_vel` is normal but the chassis does not move

## Output

Keep the diagnosis concise and structured:

- problem category
- confirmed normal items
- abnormal item(s)
- current conclusion
- next 1-3 checks
- recommended action
- verification method
