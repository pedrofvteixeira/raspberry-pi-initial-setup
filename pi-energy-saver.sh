#!/bin/sh

###
# https://scribles.net/disabling-bluetooth-on-raspberry-pi/
# https://www.raspberrypi.org/forums/viewtopic.php?p=1286812
# https://stackoverflow.com/questions/23487728/ethernet-disabling-in-raspberry-pi#37952479
# https://thomas.vanhoutte.be/miniblog/disable-the-red-and-green-lights-on-a-raspberry-pi/
##

ENABLED=1
DISABLED=0

CHOICE="$DISABLED"

BLUETOOTH_OVERLAY="pi3-disable-bt"
if [ "${CHOICE}" = "${ENABLED}" ]; then BLUETOOTH_OVERLAY="pi3-enable-bt"; fi	

echo "-- start --"

echo "-- setting green (activity) light to ${CHOICE} --"
echo ${CHOICE} > /sys/class/leds/led0/brightness

echo "-- setting red (power) light to ${CHOICE} --"
echo ${CHOICE} > /sys/class/leds/led1/brightness

echo "-- setting ethernet+usb chip's power draw to ${CHOICE} --"
echo ${CHOICE} > /sys/devices/platform/soc/3f980000.usb/buspower

echo "-- setting bluetooth to ${BLUETOOTH_OVERLAY} --"
echo "dtoverlay=${BLUETOOTH_OVERLAY}" >> /boot/config.txt

echo "-- done --"
