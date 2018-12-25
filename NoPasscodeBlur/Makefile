include $(THEOS)/makefiles/common.mk
TARGET = iphone:clang:9.2:latest

GO_EASY_ON_ME = 1
TWEAK_NAME = NoBlur
NoBlur_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 backboardd"
SUBPROJECTS += noblur
include $(THEOS_MAKE_PATH)/aggregate.mk
