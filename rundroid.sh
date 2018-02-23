#!/bin/bash

ANDROID_HOME=`pwd`
PATH=${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin::${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/build-tools:${PATH}

IMG=${IMG:-""}

if [[ $IMG = "" ]]; then
  echo "IMG environment variable required"
fi

./tools/emulator -avd $IMG -gpu on -skin 1080x1920