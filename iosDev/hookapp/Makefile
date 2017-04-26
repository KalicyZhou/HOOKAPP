THEOS_DEVICE_IP = root@localhost -p 2222
ARCHS = armv7 arm64
TARGET = iphone:latest:8.0
include $(THEOS)/makefiles/common.mk
TWEAK_NAME = HOOKAPP
HOOKAPP_FILES = Tweak.xm
HOOKAPP_FRAMEWORKS = UIKit
include $(THEOS_MAKE_PATH)/tweak.mk
after-install::
	install.exec "killall -9 SpringBoard"
