#!/bin/bash

# Task 1: Create a directory
mkdir -p /usr/lib/droid-vendor-overlay/lib64/hw

# Task 2: Create a file
touch /usr/lib/droid-vendor-overlay/lib64/hw/gralloc.default.so

# Task 3: Create mount-android.sh file
touch /usr/sbin/mount-android.sh

# Task 4: Add lines to mount-android.sh
echo "mount /dev/mapper/dynpart-odm /android/odm" | sudo tee -a /usr/sbin/mount-android.sh
echo "mount /dev/mapper/dynpart-odm /var/lib/lxc/android/rootfs/odm" | sudo tee -a /usr/sbin/mount-android.sh

# Task 5: Create device-hacks file
touch /usr/bin/device-hacks

# Task 6: Add lines to device-hacks
echo "#!/bin/sh" | sudo tee /usr/bin/device-hacks
echo "" | sudo tee -a /usr/bin/device-hacks
echo "# Wait for the property system to be up." | sudo tee -a /usr/bin/device-hacks
echo "while [ ! -e /dev/socket/property_service ]; do sleep 0.1; done" | sudo tee -a /usr/bin/device-hacks
echo "" | sudo tee -a /usr/bin/device-hacks
echo "# Wait for nvram to be loaded." | sudo tee -a /usr/bin/device-hacks
echo 'while [ "$(getprop vendor.service.nvram_init)" != "Ready" ]; do sleep 0.2; done' | sudo tee -a /usr/bin/device-hacks
echo 'while [ "$(getprop vendor.mtk.nvram.ready)" != "1" ]; do sleep 0.2; done' | sudo tee -a /usr/bin/device-hacks
echo "" | sudo tee -a /usr/bin/device-hacks
echo "# enable Wi-Fi adapter in client mode" | sudo tee -a /usr/bin/device-hacks
echo 'while [ ! -e /dev/wmtWifi ]; do sleep 0.2; done' | sudo tee -a /usr/bin/device-hacks
echo 'echo S > /dev/wmtWifi' | sudo tee -a /usr/bin/device-hacks
echo "" | sudo tee -a /usr/bin/device-hacks
echo '# set wifi.interface property since urfkill.conf expects that' | sudo tee -a /usr/bin/device-hacks
echo 'setprop wifi.interface wlan0' | sudo tee -a /usr/bin/device-hacks
echo "" | sudo tee -a /usr/bin/device-hacks
echo "# ignore second Wi-Fi interface in NetworkManager" | sudo tee -a /usr/bin/device-hacks
echo 'nmcli device set wlan1 managed false || true' | sudo tee -a /usr/bin/device-hacks
echo "" | sudo tee -a /usr/bin/device-hacks
echo "# Enable WoWLAN to avoid network disconnect before suspend" | sudo tee -a /usr/bin/device-hacks
echo 'while [ ! -e /sys/class/ieee80211/phy0 ]; do sleep 1; done' | sudo tee -a /usr/bin/device-hacks
echo 'iw phy phy0 wowlan enable magic-packet' | sudo tee -a /usr/bin/device-hacks

# Task 7: Make device-hacks executable
chmod +x /usr/bin/device-hacks

# Task 8: Create device-hacks.service file
touch /usr/lib/systemd/system/device-hacks.service

# Task 9: Add lines to device-hacks.service
echo "[Unit]" | sudo tee /usr/lib/systemd/system/device-hacks.service
echo "Description=Device Hacks" | sudo tee -a /usr/lib/systemd/system/device-hacks.service
echo "After=lxc@android" | sudo tee -a /usr/lib/systemd/system/device-hacks.service
echo "" | sudo tee -a /usr/lib/systemd/system/device-hacks.service
echo "[Service]" | sudo tee -a /usr/lib/systemd/system/device-hacks.service
echo "Type=oneshot" | sudo tee -a /usr/lib/systemd/system/device-hacks.service
echo "RemainAfterExit=yes" | sudo tee -a /usr/lib/systemd/system/device-hacks.service
echo "ExecStart=/usr/bin/device-hacks" | sudo tee -a /usr/lib/systemd/system/device-hacks.service
echo "" | sudo tee -a /usr/lib/systemd/system/device-hacks.service
echo "[Install]" | sudo tee -a /usr/lib/systemd/system/device-hacks.service
echo "WantedBy=multi-user.target" | sudo tee -a /usr/lib/systemd/system/device-hacks.service

# Task 10: Enable device-hacks.service
sudo systemctl enable /usr/lib/systemd/system/device-hacks.service

# Task 11: Create phosh directory
mkdir -p /etc/phosh

# Task 12: Create phoc.ini file
touch /etc/phosh/phoc.ini

# Task 13: Add lines to phoc.ini
echo "#[core]" | sudo tee /etc/phosh/phoc.ini
echo "#xwayland=false" | sudo tee -a /etc/phosh/phoc.ini
echo "" | sudo tee -a /etc/phosh/phoc.ini
echo "[output:DSI-1]" | sudo tee -a /etc/phosh/phoc.ini
echo "scale = 2" | sudo tee -a /etc/phosh/phoc.ini
echo "" | sudo tee -a /etc/phosh/phoc.ini
echo "[output:Virtual-1]" | sudo tee -a /etc/phosh/phoc.ini
echo "# For the x86 VM using QXL to get a phone like geometry" | sudo tee -a /etc/phosh/phoc.ini
echo "modeline = 87.25  720 776 848 976  1440 1443 1453 1493 -hsync +vsync" | sudo tee -a /etc/phosh/phoc.ini
echo "mode = 720x1440" | sudo tee -a /etc/phosh/phoc.ini
echo "scale = 2" | sudo tee -a /etc/phosh/phoc.ini
echo "" | sudo tee -a /etc/phosh/phoc.ini
echo "[output:X11-1]" | sudo tee -a /etc/phosh/phoc.ini
echo "mode = 360x720" | sudo tee -a /etc/phosh/phoc.ini
echo "#rotate = 90" | sudo tee -a /etc/phosh/phoc.ini
echo "scale = 1" | sudo tee -a /etc/phosh/phoc.ini
echo "" | sudo tee -a /etc/phosh/phoc.ini
echo "[output:WL-1]" | sudo tee -a /etc/phosh/phoc.ini
echo "mode = 360x720" | sudo tee -a /etc/phosh/phoc.ini
echo "#rotate = 90" | sudo tee -a /etc/phosh/phoc.ini
echo "scale = 1" | sudo tee -a /etc/phosh/phoc.ini
echo "" | sudo tee -a /etc/phosh/phoc.ini
echo "[output:HWCOMPOSER-1]" | sudo tee -a /etc/phosh/phoc.ini
echo "scale = 2.0" | sudo tee -a /etc/phosh/phoc.ini

echo "Tasks completed successfully!"
