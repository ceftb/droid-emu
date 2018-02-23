SDK_VERSION=3859397

.PHONY: all
all: | amu

sdk-tools-linux-$(SDK_VERSION).zip:
	wget https://dl.google.com/android/repository/sdk-tools-linux-$(SDK_VERSION).zip

tools: | sdk-tools-linux-$(SDK_VERSION).zip
	unzip sdk-tools-linux-$(SDK_VERSION).zip

platforms:
	echo "y" | ./tools/bin/sdkmanager "platforms;android-26"

build-tools:
	echo "y" | ./tools/bin/sdkmanager "build-tools;26.0.0"

platform-tools:
	echo "y" | ./tools/bin/sdkmanager "platform-tools"

~/.android/repositories.cfg:
	touch ~/.android/repositories.cfg

#system-images/android-25/google_apis/arm64-v8a: | tools
#	echo "y" | ./tools/bin/sdkmanager "system-images;android-25;google_apis;arm64-v8a"

system-images/android-26/google_apis/x86_64: | tools
	echo "y" | ./tools/bin/sdkmanager "system-images;android-26;google_apis;x86_64"

amu: pixel-oreo-26-x86_64

#.PHONY: pixel-oreo-25-arm
#pixel-oreo-25-arm:
#	DEVICE=pixel \
#	ANDROID_VERSION=8.0.0 \
#	IMAGE_ARCH=arm64-v8a \
#	AMU_PATH="`pwd`/amu" \
#	API_LEVEL=25 \
#	./buildavd.sh

.PHONY: pixel-oreo-26-x86_64
pixel-oreo-26-x86_64: | tools platforms build-tools platform-tools ~/.android/repositories.cfg tools system-images/android-26/google_apis/x86_64
	DEVICE=pixel \
	ANDROID_VERSION=8.0.0 \
	IMAGE_ARCH=x86_64 \
	AMU_PATH="`pwd`/amu" \
	API_LEVEL=26 \
	./buildavd.sh


.PHONY: run-pixel-oreo-26-x86
run-pixel-oreo-26-x86: 
	IMG=pixel_8.0.0 ./rundroid.sh
