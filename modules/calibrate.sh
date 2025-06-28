#!/bin/bash
# UDE Controller Tuner
# Fixes stick drift and improves response

# Set deadzones (5-20%)
echo 10 > /sys/class/input/js0/deadzone  # Left stick
echo 10 > /sys/class/input/js1/deadzone  # Right stick

# Increase polling rate
echo 200 > /sys/class/input/js0/pollrate # Hz

echo "[UDE] Controller calibrated: 10% deadzone, 200Hz polling"
