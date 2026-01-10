#!/bin/bash

# Get CPU temperature for modern AMD CPUs from the k10temp module.
# It looks for the 'Tctl' value, which represents the package temperature.
cpu_temp=$(sensors k10temp-pci-00c3 | awk '/^Tctl:/ {print $2}' | tr -d '+°C' | cut -d. -f1)

# Get CPU usage as a whole number percentage.
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{printf "%.0f%%", 100 - $8}')

# Output for Waybar, e.g., " 15% (45°C)"
echo " ${cpu_usage} (${cpu_temp}°)"