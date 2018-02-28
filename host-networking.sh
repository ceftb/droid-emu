#!/bin/bash

set -e

sudo ip link add br47 type bridge
sudo ip tuntap add dev tap47 mode tap user $(whoami)
sudo ip link set tap47 master br47
sudo ip link set dev br47 up
sudo ip link set dev tap47 up

sudo ip link add br48 type bridge
sudo ip tuntap add dev tap48 mode tap user $(whoami)
sudo ip link set tap48 master br48
sudo ip link set dev br48 up
sudo ip link set dev tap48 up

sudo ip link add br49 type bridge
sudo ip tuntap add dev tap49 mode tap user $(whoami)
sudo ip link set tap49 master br49
sudo ip link set dev br49 up
sudo ip link set dev tap49 up
