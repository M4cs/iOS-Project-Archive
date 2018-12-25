include $(THEOS)/makefiles/common.mk

TWEAK_NAME = DarkSwitcher
DarkSwitcher_FILES = Tweak.xm
DarkSwitcher_CFLAGS = -fobjc-arc -Wno-deprecated-declarations

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += darkswitcherprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
