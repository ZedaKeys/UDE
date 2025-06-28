#!/bin/bash
# UDE Real-Time Performance Dashboard
watch -n 0.5 '
  echo -e "\e[1m=== UDE Performance Dashboard ===\e[0m"
  echo "CPU: $(cat /sys/class/thermal/thermal_zone*/temp | head -1 | awk "{print \$1/1000}")°C | $(grep "cpu MHz" /proc/cpuinfo | head -1 | awk "{print \$4/1000}")GHz"
  echo "GPU: $(cat /sys/class/drm/card0/device/hwmon/hwmon*/temp1_input | awk "{print \$1/1000}")°C | $(cat /sys/class/drm/card0/device/pp_dpm_sclk | grep "*" | awk "{print \$2}")MHz"
  echo "Power: $(cat /sys/class/hwmon/hwmon*/power1_average | awk "{print \$1/1000000}")W | FPS: $(cat /sys/class/drm/card0/device/hwmon/hwmon*/fps)"
'
