#!/bin/bash

# Step 1: Clone the git repository
git clone https://github.com/NeelamArunkumar/droidian-script.git

# Step 2: Change to the cloned directory
cd droidian-script

# Step 3: Copy the rules file to /etc/udev/rules.d/ with sudo
sudo cp 70-denniz.rules /etc/udev/rules.d/

# Notify user about successful completion
echo "Git repo cloned and udev rules copied successfully."
