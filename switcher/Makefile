include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Switcher
Switcher_FILES = Tweak.xm
Switcher_FRAMEWORK = Foundation

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += switcherprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
