#!/bin/bash
# UDE Performance Module v3.1
# License: GPLv3

# ======================
# CONFIG LOADER - START
# ======================
CONFIG_DIR="$HOME/.config/ude"
GLOBAL_CONFIG="/etc/ude.conf"
DEFAULT_CONFIG="$(dirname "$0")/../configs/ude-default.conf"

# Initialize default values
log_level="info"
default_tdp=10
max_temp_cpu=90
max_temp_gpu=85

# Load config hierarchy
load_config() {
    # 1. Load defaults
    if [ -f "$DEFAULT_CONFIG" ]; then
        while IFS='=' read -r key value; do
            if [[ $key == \[*] ]]; then
                section=${key#\[}
                section=${section%\]}
            elif [[ $key != "" ]] && [[ $value != "" ]]; then
                declare -g "${section}_${key}=${value}"
            fi
        done < "$DEFAULT_CONFIG"
    fi

    # 2. Load system config
    if [ -f "$GLOBAL_CONFIG" ]; then
        source "$GLOBAL_CONFIG"
    fi

    # 3. Load user config
    if [ -f "$CONFIG_DIR/user.conf" ]; then
        source "$CONFIG_DIR/user.conf"
    fi
}

load_config
# ====================
# CONFIG LOADER - END
# ====================

# Core Functions
set_tdp() {
    echo "[UDE] Setting TDP to $1W (Max CPU: ${performance_max_temp_cpu}C, GPU: ${performance_max_temp_gpu}C)"
    echo $1 > /sys/class/hwmon/hwmon*/power1_cap
}

set_gpu() {
    echo "[UDE] Setting GPU to $1MHz"
    echo "manual" > /sys/class/drm/card0/device/power_dpm_force_performance_level
    echo $1 > /sys/class/drm/card0/device/pp_dpm_sclk
}

# Game Profiles
load_profile() {
    case "$1" in
        "cyberpunk")
            set_tdp $default_tdp
            set_gpu 1600
            ;;
        "baldurs_gate_3")
            set_tdp 12
            set_gpu 1300
            ;;
        *)
            echo "Error: Unknown game '$1'"
            exit 1
            ;;
    esac
}

# Main Execution
if [ -z "$1" ]; then
    echo "Usage: $0 [game_name]"
    echo "Configured TDP: $default_tdp W"
    exit 1
fi

load_profile "$1"
