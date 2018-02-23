#!/bin/bash

# Required environment variables
# ------------------------------
#
# DEVICE: the name of the android device ~ 'nexus 7', 'pixel'
# ANDROID_VERSION: The numeric version of Android ~ 8.0.0 for 'Oreo'
# API_LEVEL: The Android API level ~ 25, 26, 27 ...
# IMAGE_ARCH: The hardware architecture of the system image ~ x86_64, arm64-v8a
# AMU_PATH: where to put android emulator state
#

DEVICE=${DEVICE:-""}
ANDROID_VERSION=${ANDROID_VERSION:-""}
API_LEVEL=${API_LEVEL:-""}
IMAGE_ARCH=${IMAGE_ARCH:-""}
AMU_PATH=${AMU_PATH:-""}

for x in DEVICE ANDROID_VERSION API_LEVEL IMAGE_ARCH AMU_PATH
do
  eval xx=\$$x
  if [[ $xx = "" ]]; then
    echo "$x environment variable required"
    exit 1
  fi
done
  


AVD_NAME=${DEVICE}_${ANDROID_VERSION}
IMG_TYPE='google_apis'

./tools/bin/avdmanager create avd -f \
  -n $AVD_NAME \
  -b $IMG_TYPE/$IMAGE_ARCH \
  -k "system-images;android-$API_LEVEL;$IMG_TYPE;$IMAGE_ARCH" \
  -d $DEVICE \
  -p $AMU_PATH

