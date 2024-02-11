#!/bin/sh

###
# https://n.ethz.ch/~dbernhard/disable-led-on-a-raspberry-pi.html
###
echo "
[Unit]
Description=Disables the power-LED and active-LED
After=multi-user.target

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=sh -c 'echo 1 | sudo tee /sys/class/leds/PWR/brightness > /dev/null && echo 0 | sudo tee /sys/class/leds/ACT/brightness > /dev/null'
ExecStop=sh -c 'echo 0 | sudo tee /sys/class/leds/PWR/brightness > /dev/null && echo 1 | sudo tee /sys/class/leds/ACT/brightness > /dev/null'

[Install]
WantedBy=multi-user.target
" >> /etc/systemd/system/disable-leds.service

echo "-- done --"
