SDK_VERSION=3859397
OS := $(shell lsb_release -is)

.PHONY: all
all: | amu

sdk-tools-linux-$(SDK_VERSION).zip:
	wget https://dl.google.com/android/repository/sdk-tools-linux-$(SDK_VERSION).zip

tools: | sdk-tools-linux-$(SDK_VERSION).zip
	unzip sdk-tools-linux-$(SDK_VERSION).zip

prereqs:
ifeq ($(OS), Ubuntu)
	sudo apt-get install -y unzip openjdk-8-jdk
else ifeq ($(OS), Debian)
	sudo apt-get install -y unzip openjdk-8-jdk
else ifeq ($(OS), Fedora)
	sudo dnf install -y java-1.8.0-openjdk
else
	echo "Install Java 1.8.0, unzip"
	exit 1
endif


licenses:
	yes | ./tools/bin/sdkmanager --licenses

platforms:
	echo "y" | ./tools/bin/sdkmanager "platforms;android-26"

build-tools:
	echo "y" | ./tools/bin/sdkmanager "build-tools;26.0.0"

platform-tools:
	echo "y" | ./tools/bin/sdkmanager "platform-tools"

~/.android/repositories.cfg:
	mkdir ~/.android
	touch ~/.android/repositories.cfg

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
pixel-oreo-26-x86_64: | prereqs tools licenses platforms build-tools platform-tools ~/.android/repositories.cfg tools system-images/android-26/google_apis/x86_64
	DEVICE=pixel \
	ANDROID_VERSION=8.0.0 \
	IMAGE_ARCH=x86_64 \
	AMU_PATH="`pwd`/amu" \
	API_LEVEL=26 \
	./buildavd.sh


.PHONY: run-pixel-oreo-26-x86
run-pixel-oreo-26-x86: 
	IMG=pixel_8.0.0 ./rundroid.sh
