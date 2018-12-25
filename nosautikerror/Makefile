include $(THEOS)/makefiles/common.mk

TWEAK_NAME = NoSaurikError
NoSaurikError_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 com.saurik.cydia"
