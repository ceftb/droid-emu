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
# lets assume allocation by 2's - adb low port, console high port
for ((; counter<=$lastport; counter+=2)); do
    if [[ ! $(netstat -nl | grep $counter) ]]; then
        break
    fi
done
echo "adb port selected:" $counter "console port:" $((counter+1))

vncstart=5900
vncstop=6200
vncselect=$vncstart
for ((; vncselect<=$vncstop; vncselect++)); do
    if [[ ! $(netstat -nl | grep $vncselect) ]]; then
        break
    fi
done
vncstart=$((vncselect-vncstart))
echo "using vnc port:" $vncselect "display:" $vncstart

EMU_ARGS="-avd $IMG -skin 1080x1920 -ports $counter,$((counter+1)) -net-tap tap47"

if [[ ! -z $LOCAL_GUI ]]; then
  ./tools/emulator $EMU_ARGS -gpu on 
else
  ./tools/emulator $EMU_ARGS -gpu off -no-window -noaudio -qemu -vnc :$vncstart
fi
