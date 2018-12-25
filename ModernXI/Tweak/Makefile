ARCHS = arm64
TARGET = iphone:clang::9.2

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ModernXI
$(TWEAK_NAME)_FILES = Tweak.xm
$(TWEAK_NAME)_EXTRA_FRAMEWORKS += Cephei

include $(THEOS_MAKE_PATH)/tweak.mk