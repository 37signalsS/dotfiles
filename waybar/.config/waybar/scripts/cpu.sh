#!/bin/bash

cpu_temp=$(sensors k10temp-pci-00c3 | awk '/^Tctl:/ {print $2}' | tr -d '+°C' | cut -d. -f1)

cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{printf "%.0f%%", 100 - $8}')

echo " ${cpu_usage} (${cpu_temp}°)"
