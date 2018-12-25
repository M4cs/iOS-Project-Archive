include $(THEOS)/makefiles/common.mk

# export TARGET = iphone:10.1:10.1

BUNDLE_NAME = EzCC
EzCC_BUNDLE_NAME = com.auxilium.haystack.EzCC
EzCC_BUNDLE_EXTENSION = bundle
EzCC_CFLAGS =  -fobjc-arc
EzCC_FILES = $(wildcard *.m)
EzCC_FRAMEWORKS = Foundation UIKit CoreGraphics CoreImage QuartzCore
EzCC_EXTRA_FRAMEWORKS = HaystackUI Haystack
EzCC_INSTALL_PATH = /Library/Haystack/Bundles/
EzCC_LDFLAGS += -F../../.theos/$(THEOS_OBJ_DIR_NAME)

include $(THEOS_MAKE_PATH)/bundle.mk
