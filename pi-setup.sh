#!/bin/sh

hostname=${1}
ip_termination=${2}

if [ -z "${hostname}" ]; then echo "missing required hostname" && exit 1; fi
if [ -z "${ip_termination}" ]; then echo "missing required ip termination" && exit 1; fi

cp -v pi-energy-saver.sh /media/pedro/rootfs/home/pi/
cp -v pi-first-boot.sh /media/pedro/rootfs/home/pi/

chmod +x /media/pedro/rootfs/home/pi/pi-energy-saver.sh
chmod +x /media/pedro/rootfs/home/pi/pi-first-boot.sh

sudo mkdir -p /media/pedro/rootfs/etc/docker

sudo cp -v daemon.json /media/pedro/rootfs/etc/docker/
echo "[/etc/docker/daemon.json]"
cat /media/pedro/rootfs/etc/docker/daemon.json

sudo echo "${hostname}" > /media/pedro/rootfs/etc/hostname
echo "[/etc/hostname]"
cat /media/pedro/rootfs/etc/hostname

sudo sed -i "s/raspberrypi/${hostname}/g" /media/pedro/rootfs/etc/hosts
sudo echo "
192.168.1.100   pi100
192.168.1.101   pi101
192.168.1.102   pi102
192.168.1.103   pi103
192.168.1.104   pi104
192.168.1.105   pi105

192.168.1.199   pi-registry
" >> /media/pedro/rootfs/etc/hosts
echo "[/etc/hosts]"
cat /media/pedro/rootfs/etc/hosts

sudo echo "
interface wlan0
static ip_address=192.168.1.${ip_termination}
static_routers=192.168.1.1
static domain_name_servers=192.168.1.1 1.1.1.1
" >> /media/pedro/rootfs/etc/dhcpcd.conf
echo "[/etc/dhcpcd.conf]"
cat /media/pedro/rootfs/etc/dhcpcd.conf

sudo echo "
auto wlan0
iface wlan0 inet static
 address 192.168.1.${ip_termination}
 netmask 255.255.255.0
 gateway 192.168.1.1
 dns-nameservers 192.168.1.1 1.1.1.1
"

