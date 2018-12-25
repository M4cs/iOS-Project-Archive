include $(THEOS)/makefiles/common.mk

TWEAK_NAME = excitant
excitant_FILES = Excitant.xm
excitant_LIBRARIES = applist excitant

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += excitant
include $(THEOS_MAKE_PATH)/aggregate.mk

