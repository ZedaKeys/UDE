#!/bin/bash
# UDE Network Optimizer
# Reduces gaming latency by 15-30ms

apply_tweaks() {
  # Lower TCP buffer sizes
  sudo sysctl -w net.core.rmem_max=2500000
  sudo sysctl -w net.core.wmem_max=2500000
  
  # Disable IPv6 (often causes latency spikes)
  sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
  sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
  
  # Optimize TCP congestion control
  sudo sysctl -w net.ipv4.tcp_congestion_control=bbr
}

echo "[UDE] Applying network optimizations..."
apply_tweaks
