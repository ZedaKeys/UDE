#!/bin/bash
# UDE Performance Module v3.2 (Fixed)
# License: GPLv3

# ======================
# CONFIG LOADER (FIXED)
# ======================
CONFIG_FILE="$HOME/UDE/configs/ude-default.conf"

# Default values
system_log_level="info"
performance_default_tdp=10
performance_max_temp_cpu=90
performance_max_temp_gpu=85
network_disable_ipv6="false"
network_tcp_optimizations="true"
backup_enabled="true"
backup_location="$HOME/ude_backups"

load_config() {
    if [ -f "$CONFIG_FILE" ]; then
        while IFS= read -r line; do
            # Skip comments and empty lines
            [[ "$line" =~ ^#|^$ ]] && continue
            
            # Parse sections
            if [[ "$line" =~ ^\[(.*)\]$ ]]; then
                section="${BASH_REMATCH[1]}"
            # Parse key=value pairs
            elif [[ "$line" =~ ^([^=]+)=(.*)$ ]]; then
                key="${BASH_REMATCH[1]}"
                value="${BASH_REMATCH[2]}"
                # Remove surrounding quotes if present
                value="${value%\"}"
                value="${value#\"}"
                # Set the variable
                declare -g "${section}_${key}=${value}"
            fi
        done < "$CONFIG_FILE"
    fi
}

# ====================
# CORE FUNCTIONALITY
# ====================
set_tdp() {
    echo "[UDE] Setting TDP to $1W"
    echo "$1" | sudo tee /sys/class/hwmon/hwmon*/power1_cap >/dev/null
}

set_gpu() {
    echo "[UDE] Setting GPU to $1MHz"
    echo "manual" | sudo tee /sys/class/drm/card0/device/power_dpm_force_performance_level >/dev/null
    echo "$1" | sudo tee /sys/class/drm/card0/device/pp_dpm_sclk >/dev/null
}

# =================
# TEST FUNCTION
# =================
run_test() {
    echo "=== UDE PERFORMANCE MODULE TEST ==="
    echo "Loaded Configuration:"
    echo "- Default TDP: ${performance_default_tdp}W"
    echo "- Max CPU Temp: ${performance_max_temp_cpu}°C"
    echo "- Max GPU Temp: ${performance_max_temp_gpu}°C"
    echo "Test completed successfully!"
}

# ================
# MAIN EXECUTION
# ================
load_config

case "$1" in
    "--test")
        run_test
        ;;
    "baldurs_gate_3")
        set_tdp "${performance_default_tdp:-12}"
        set_gpu 1300
        echo "Baldur's Gate 3: ${performance_default_tdp:-12}W TDP, 1300MHz GPU"
        ;;
    "cyberpunk")
        set_tdp 15
        set_gpu 1600
        echo "Cyberpunk 2077: 15W TDP, 1600MHz GPU"
        ;;
    *)
        echo "Usage: $0 [--test|game_name]"
        echo "Available games: baldurs_gate_3, cyberpunk"
        exit 1
        ;;
esac
