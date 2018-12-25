include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ColorMyCC
ColorMyCC_FILES = Tweak.xm
ColorMyCC_LIBRARIES = colorpicker
include $(THEOS_MAKE_PATH)/tweak.mk


after-install ::
	killall -9 SpringBoard
SUBPROJECTS += colormycc
include $(THEOS_MAKE_PATH)/aggregate.mk
