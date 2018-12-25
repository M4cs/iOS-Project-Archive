export ARCH = arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ColorSwitcher
ColorSwitcher_FILES = Tweak.xm
ColorSwitcher_LIBRARIES = colorpicker

FINAL_PACKAGE = 1

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
	
SUBPROJECTS += colorswitcherPrefs
include $(THEOS_MAKE_PATH)/aggregate.mk