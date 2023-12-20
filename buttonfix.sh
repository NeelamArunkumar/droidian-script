#!/bin/bash

# Task 1: Clone the repository
git clone https://github.com/NeelamArunkumar/brightness-helper.git -b /home/droidian/brightness-helper

# Task 2: Change to the brightness-helper directory
cd /home/droidian/brightness-helper

# Task 3: Install gcc
sudo apt install gcc

# Task 4: Install libc6-dev
sudo apt-get install libc6-dev

# Task 5: Compile oneHelper.c
gcc oneHelper.c

# Task 6: Rename the output file
mv a.out one.out

# Task 7: Compile twoHelper.c
gcc twoHelper.c

# Task 8: Rename the output file
mv a.out two.out

# Task 9: Create one.service file
echo "[Unit]" | sudo tee /lib/systemd/system/one.service
echo "Description=powerOne" | sudo tee -a /lib/systemd/system/one.service
echo "After=multi-user.target" | sudo tee -a /lib/systemd/system/one.service
echo "" | sudo tee -a /lib/systemd/system/one.service
echo "[Service]" | sudo tee -a /lib/systemd/system/one.service
echo "ExecStart=/home/droidian/brightness-helper/one.out" | sudo tee -a /lib/systemd/system/one.service
echo "Restart=always" | sudo tee -a /lib/systemd/system/one.service
echo "User=root" | sudo tee -a /lib/systemd/system/one.service
echo "" | sudo tee -a /lib/systemd/system/one.service
echo "[Install]" | sudo tee -a /lib/systemd/system/one.service
echo "WantedBy=multi-user.target" | sudo tee -a /lib/systemd/system/one.service

# Task 10: Create two.service file
echo "[Unit]" | sudo tee /lib/systemd/system/two.service
echo "Description=powerTwo" | sudo tee -a /lib/systemd/system/two.service
echo "After=multi-user.target" | sudo tee -a /lib/systemd/system/two.service
echo "" | sudo tee -a /lib/systemd/system/two.service
echo "[Service]" | sudo tee -a /lib/systemd/system/two.service
echo "ExecStart=/home/droidian/brightness-helper/two.out" | sudo tee -a /lib/systemd/system/two.service
echo "Restart=always" | sudo tee -a /lib/systemd/system/two.service
echo "User=root" | sudo tee -a /lib/systemd/system/two.service
echo "" | sudo tee -a /lib/systemd/system/two.service
echo "[Install]" | sudo tee -a /lib/systemd/system/two.service
echo "WantedBy=multi-user.target" | sudo tee -a /lib/systemd/system/two.service

# Task 11: Reload systemd
sudo systemctl daemon-reload

# Task 12: Enable one.service
sudo systemctl enable /lib/systemd/system/one.service

# Task 13: Enable two.service
sudo systemctl enable /lib/systemd/system/two.service

# Task 14: Start one.service
sudo systemctl start /lib/systemd/system/one.service

# Task 15: Start two.service
sudo systemctl start /lib/systemd/system/two.service

echo "Tasks completed successfully!"
