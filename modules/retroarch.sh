#!/bin/bash
# UDE RetroArch Tweaks
CONFIG="$HOME/.config/retroarch/retroarch.cfg"

apply_settings() {
  sed -i 's/^video_threaded.*/video_threaded = "true"/' "$CONFIG"
  sed -i 's/^video_vsync.*/video_vsync = "false"/' "$CONFIG"
  sed -i 's/^video_frame_delay.*/video_frame_delay = "2"/' "$CONFIG"
}

apply_settings
echo "[UDE] RetroArch optimized for Steam Deck"
