#!/bin/bash
# mount_volume.sh - Automates EBS volume formatting and mounting

DEVICE="/dev/xvdf"
MOUNT_POINT="/production-data"

echo "Checking if device $DEVICE exists..."
if [ ! -b "$DEVICE" ]; then
    echo "Error: Device $DEVICE not found. Please attach the EBS volume."
    exit 1
fi

echo "Checking filesystem type on $DEVICE..."
FS_TYPE=$(sudo blkid -s TYPE -o value "$DEVICE")

if [ -z "$FS_TYPE" ]; then
    echo "No filesystem detected. Formatting $DEVICE with ext4..."
    sudo mkfs -t ext4 "$DEVICE"
else
    echo "Filesystem $FS_TYPE already exists on $DEVICE."
fi

echo "Creating mount point directory: $MOUNT_POINT"
sudo mkdir -p "$MOUNT_POINT"

echo "Mounting $DEVICE to $MOUNT_POINT..."
sudo mount "$DEVICE" "$MOUNT_POINT"

echo "Volume successfully mounted! Current disk usage:"
df -h "$MOUNT_POINT"
