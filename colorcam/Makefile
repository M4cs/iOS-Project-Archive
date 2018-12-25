include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ColorCam
ColorCam_FILES = Tweak.xm
ColorCam_LIBRARIES = colorpicker

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += colorcamprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
