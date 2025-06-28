#!/bin/bash
# UDE Performance Module v1.2
# License: GPLv3

REQUIRED_STEAMOS_VER="3.6"

check_steamos_ver() {
  current_ver=$(grep "STEAMOS_VERSION" /etc/os-release | cut -d= -f2)
  if [ "$(printf '%s\n' "$REQUIRED_STEAMOS_VER" "$current_ver" | sort -V | head -n1)" != "$REQUIRED_STEAMOS_VER" ]; then
    echo "ERROR: Requires SteamOS $REQUIRED_STEAMOS_VER+"
    exit 1
  fi
}

# Simulated Controls (Safe for Testing)
set_tdp() {
  echo "[UDE] TDP set to $1W"
}

set_gpu() {
  echo "[UDE] GPU set to $1MHz"
}

toggle_smt() {
  echo "[UDE] SMT $1"
}

# Game Profiles
load_profile() {
  case "$1" in
    "cyberpunk")
      set_tdp 15
      set_gpu 1600
      toggle_smt on
      echo "Cyberpunk 2077: 15W TDP, 1600MHz GPU, SMT On"
      ;;
      
    "oblivion_remastered")
      check_steamos_ver
      set_tdp 9
      set_gpu 1100
      toggle_smt on
      echo "Oblivion Remastered (2025):"
      echo "- 9W TDP, 1100MHz GPU"
      echo "- Optimized for 60FPS at 1152x720"
      echo "- FSR Ultra Quality enabled"
      ;;
      
    *)
      echo "Error: Unknown game profile '$1'"
      echo "Available profiles: cyberpunk, oblivion_remastered"
      ;;
  esac
}

# Main Menu
echo "--------------------------------------------------"
echo "Ultimate Deck Experience - Performance Module v1.2"
echo "--------------------------------------------------"
echo "Usage: ./performance.sh [game_name]"
echo "Available games: cyberpunk, oblivion_remastered"
echo "--------------------------------------------------"

# Execute if argument given
if [ ! -z "$1" ]; then
  load_profile "$1"
fi
