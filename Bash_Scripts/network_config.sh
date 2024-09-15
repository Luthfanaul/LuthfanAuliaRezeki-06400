#!/bin/bash

# Get the current IP address and subnet mask
IP_ADDRESS=$(ip -o -4 addr show eth0 | awk '{print $4}')
SUBNET_MASK=$(ifconfig eth0 | grep -w inet | awk '{print $4}')

# Get the default gateway
DEFAULT_GATEWAY=$(ip route | grep default | awk '{print $3}')

# Output the current network configuration
echo "Current IP Address: $IP_ADDRESS"
echo "Subnet Mask: $SUBNET_MASK"
echo "Default Gateway: $DEFAULT_GATEWAY"

# Verify network connectivity to www.google.com
echo "Checking connectivity to www.google.com..."

if ping -c 4 www.google.com > /dev/null 2>&1; then
    echo "Network connectivity: OK"
else
    echo "Network connectivity: FAILED"
fi
