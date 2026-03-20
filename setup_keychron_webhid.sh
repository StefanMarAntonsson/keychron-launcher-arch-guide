#!/bin/bash

echo "Scanning for Keychron devices..."
# Find all Keychron devices using lsusb
devices=$(lsusb | grep -i "keychron")

if [ -z "$devices" ]; then
    echo "Error: No Keychron devices found. Please ensure they are plugged in via USB cable."
    exit 1
fi

echo "Found the following devices:"
echo "$devices"
echo "----------------------------------------"

# Loop through each detected device
while read -r line; do
    # Extract the VID:PID pair (Field 6 in standard lsusb output)
    id_pair=$(echo "$line" | awk '{print $6}')
    vid=$(echo "$id_pair" | cut -d':' -f1)
    pid=$(echo "$id_pair" | cut -d':' -f2)
    
    # Define a dynamic file name based on the IDs to prevent overwriting
    rule_file="/etc/udev/rules.d/50-keychron-${vid}-${pid}.rules"
    
    echo "Configuring WebHID access for Device ID: $vid:$pid"
    
    # Generate the udev rule content
    rule_content="# Dynamically generated WebHID rule for Keychron ($vid:$pid)
KERNEL==\"hidraw*\", SUBSYSTEM==\"hidraw\", ATTRS{idVendor}==\"$vid\", ATTRS{idProduct}==\"$pid\", MODE=\"0666\", TAG+=\"uaccess\", TAG+=\"udev-acl\""
    
    # Write the rule to the system directory
    echo "$rule_content" | sudo tee "$rule_file" > /dev/null
    echo "Created rule file: $rule_file"

done <<< "$devices"

echo "----------------------------------------"
echo "Reloading udev rules..."
sudo udevadm control --reload-rules
sudo udevadm trigger

echo "Setup complete! Please UNPLUG and REPLUG all Keychron keyboards to apply the new permissions."
