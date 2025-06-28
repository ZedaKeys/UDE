#!/bin/bash
# UDE Fan Control
MODE=${1:-balanced}  # Default: balanced

case $MODE in
  "quiet")
    echo 12000 > /sys/class/hwmon/hwmon*/fan1_target
    ;;
  "balanced")
    echo 18000 > /sys/class/hwmon/hwmon*/fan1_target
    ;;
  "performance")
    echo 25000 > /sys/class/hwmon/hwmon*/fan1_target
    ;;
esac

echo "[UDE] Fan set to $MODE mode"
