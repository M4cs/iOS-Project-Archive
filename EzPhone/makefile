include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = EzPhone
EzPhone_BUNDLE_EXTENSION = bundle
EzPhone_CFLAGS +=  -fobjc-arc -I$(THEOS)/include
EzPhone_ADDITIONAL_FRAMEWORKS = ControlCenterUIKit
EzPhone_FILES = $(wildcard *.m)
EzPhone_LDFLAGS += /opt/projects/EzPhone/Frameworks/ControlCenterUIKit.tbd
EzPhone_INSTALL_PATH = /Library/ControlCenter/Bundles/

include $(THEOS_MAKE_PATH)/bundle.mk
