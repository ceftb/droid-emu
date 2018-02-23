#!/bin/bash

set -e

sudo ip link add br47 type bridge
sudo ip tuntap add dev tap47 mode tap user $(whoami)
sudo ip link set tap47 master br47
sudo ip link set dev br47 up
sudo ip link set dev tap47 up
