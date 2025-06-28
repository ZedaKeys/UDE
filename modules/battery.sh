#!/bin/bash
# UDE Battery Saver
echo 8 > /sys/class/hwmon/hwmon*/power1_cap
echo 800 > /sys/class/drm/card0/device/pp_dpm_sclk
echo 40 > /sys/class/drm/card0/device/hwmon/hwmon*/fps_max
echo powersave | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
echo "[UDE] Battery Saver Mode: 8W TDP, 800MHz GPU, 40FPS cap"
