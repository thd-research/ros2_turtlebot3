#!/bin/bash
#~/up
apt-get install dphys-swapfile
echo "CONF_SWAPSIZE=2048"|tee -a /etc/dphys-swapfile
dphys-swapfile setup
dphys-swapfile swapon
systemctl restart dphys-swapfile.service
systemctl status dphys-swapfile.service
free -h
EOF