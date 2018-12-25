include $(THEOS)/makefiles/common.mk

TWEAK_NAME = StatusNotifications
StatusNotifications_FILES = $(wildcard *.mm) $(wildcard *.m) $(wildcard *.xm)

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
