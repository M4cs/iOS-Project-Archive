TARGET = iphone:clang::11.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = BetterSwitcher
BetterSwitcher_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
