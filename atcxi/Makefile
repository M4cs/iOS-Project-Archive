include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ATCXI
ATCXI_FILES = Tweak.xm
ATCXI_PRIVATE_FRAMEWORKS = CoreTelephony

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
