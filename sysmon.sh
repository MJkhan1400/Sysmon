#!/bin/bash

# Display a simple ASCII banner
echo "============================="
echo "      System Monitor        "
echo "============================="

# Get system information
echo ""
echo "CPU Usage:"
top -bn1 | grep "Cpu(s)" | \
sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
awk '{print 100 - $1"% CPU Usage"}'

echo ""
echo "Memory Usage:"
free -h | grep Mem | awk '{printf "Used: %s / Total: %s\n", $3, $2}'

echo ""
echo "Disk Usage:"
df -h | grep '^/dev/' | awk '{printf "%s: Used %s / Total %s (%s)\n", $1, $3, $2, $5}'

echo ""
echo "Network Activity:"
echo "Incoming traffic (bytes): $(cat /sys/class/net/$(ip route show default | awk '/default/ {print $5}')/statistics/rx_bytes)"
echo "Outgoing traffic (bytes): $(cat /sys/class/net/$(ip route show default | awk '/default/ {print $5}')/statistics/tx_bytes)"

echo ""
echo "============================="


