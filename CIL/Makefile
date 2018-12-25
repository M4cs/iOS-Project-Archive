include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ConfirmInstaLike
ConfirmInstaLike_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 Instagram"
# SUBPROJECTS += confirminstaprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
