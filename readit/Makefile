include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ReadIt
ReadIt_FILES = Tweak.xm
BUNDLE_NAME = ReadItSounds

ReadItSounds_INSTALL_PATH = /Library/Application Support/

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
