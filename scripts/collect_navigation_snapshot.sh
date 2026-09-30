#!/usr/bin/env bash
set -u

section() {
  printf '\n===== %s =====\n' "$1"
}

run_safe() {
  printf '$ %s\n' "$*"
  "$@" 2>&1 || printf '[WARN] command failed or is unavailable\n'
}

section "Environment"
printf 'ROS_DISTRO=%s\n' "${ROS_DISTRO:-<unset>}"
printf 'ROS_DOMAIN_ID=%s\n' "${ROS_DOMAIN_ID:-<unset>}"

if ! command -v ros2 >/dev/null 2>&1; then
  echo "[ERROR] ros2 command not found. Source the ROS 2 environment first."
  exit 2
fi

section "ROS 2 nodes"
run_safe ros2 node list

section "ROS 2 topics"
run_safe ros2 topic list

section "/cmd_vel info"
run_safe ros2 topic info /cmd_vel

section "/map info"
run_safe ros2 topic info /map

section "global_localization_node parameters"
run_safe ros2 param list /global_localization_node

if command -v systemctl >/dev/null 2>&1; then
  section "nav-core.service"
  run_safe systemctl --no-pager --full status nav-core.service
fi

cat <<'EOF'

Snapshot complete.
This script performs read-only checks only.
Use the SKILL.md workflow to decide the next diagnostic step.
EOF
