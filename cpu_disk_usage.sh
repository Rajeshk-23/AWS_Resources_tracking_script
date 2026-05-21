##################
#Author: Rajesh kunnuthala
#Date: 21/05/2026
#!/bin/bash

THRESHOLD=80

DISK_USAGE=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')
CPU_USAGE=$(top -bn1 | grep "Cpu" | awk '{print $2 + $4}')

echo "Disk Usage: $DISK_USAGE%"
echo "CPU Usage: $CPU_USAGE%"

if [ $DISK_USAGE -gt $THRESHOLD ]; then
    echo "WARNING: Disk usage is above threshold!"
fi
