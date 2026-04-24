#!/bin/bash
#~/up
sudo apt-get install -y dphys-swapfile
echo "CONF_SWAPSIZE=2048"|tee -a /etc/dphys-swapfile
dphys-swapfile setup
sudo dphys-swapfile swapon
sudo systemctl restart dphys-swapfile.service
sudo systemctl status dphys-swapfile.service
free -h
EOF
