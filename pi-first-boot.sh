#!/bin/sh

touch /home/pi/.bash_aliases
echo "alias ll='ls -laF'" > /home/pi/.bash_aliases

##
# install handy packages
##
apt update && apt install -y screen vim htop

##
# install windscribe for arm
##
#wget https://windscribe.com/install/desktop/linux_deb_arm -o windscribe_arm.deb 
#dpkg -i windscribe_arm.deb

##
# install go
##
#wget https://dl.google.com/go/go1.18.3.linux-armv64.tar.gz -O go.tar.gz
#tar -C /usr/local -xzf go.tar.gz
#echo "export GOPATH=$HOME/go" >> /home/pi/.bashrc
#echo "export PATH=/usr/local/go/bin:$PATH:$GOPATH/bin" >> /home/pi/.bashrc

##
# install docker
##
sudo apt update
sudo apt install -y \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common

# Get the Docker signing key for packages
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo apt-key add -

# Add the Docker official repos
echo "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
     $(lsb_release -cs) stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list

# Install Docker
sudo apt update
sudo apt install -y --no-install-recommends \
    docker-ce \
    cgroupfs-mount

usermod -aG docker pi

sudo systemctl enable docker
sudo systemctl start docker


echo "setup finished, rebooting..."
reboot
