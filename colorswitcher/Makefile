export ARCH = armv6 armv6s armv7 armv7s arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ColorSwitcher
ColorSwitcher_FILES = Tweak.xm
ColorSwitcher_LIBRARIES = colorpicker

FINAL_PACKAGE = 1

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += colorswitcherprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
