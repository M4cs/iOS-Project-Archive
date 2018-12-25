include $(THEOS)/makefiles/common.mk

TWEAK_NAME = RemindHome
RemindHome_FILES = Tweak.xm
RemindHome_LIBRARIES = colorpicker

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += remindhomeprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
