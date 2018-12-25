include $(THEOS)/makefiles/common.mk

TWEAK_NAME = NoMoreBanners
NoMoreBanners_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += nomorebanners
include $(THEOS_MAKE_PATH)/aggregate.mk
