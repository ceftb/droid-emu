#!/bin/bash

ANDROID_HOME=`pwd`
PATH=${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin::${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/build-tools:${PATH}

IMG=${IMG:-""}

if [[ $IMG = "" ]]; then
  echo "IMG environment variable required"
fi

# The valid ports range is 5554 to 5682
firstport=5554
lastport=5682
counter=$firstport
IP=localhost
# lets assume allocation by 2's - adb low port, console high port
for ((; counter<=$lastport; counter+=2)); do
    if [[ ! $(netstat -nl | grep $counter) ]]; then
        break
    fi
done
echo "adb port selected:" $counter "console port:" $((counter+1))

./tools/emulator -avd $IMG -gpu off -skin 1080x1920 -no-window -noaudio -ports $counter,$counter+1 -qemu -vnc :100
