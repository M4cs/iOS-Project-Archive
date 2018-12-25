include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = EzFieldTest
EzFieldTest_BUNDLE_EXTENSION = bundle
EzFieldTest_CFLAGS +=  -fobjc-arc -I$(THEOS)/include
EzFieldTest_ADDITIONAL_FRAMEWORKS = ControlCenterUIKit
EzFieldTest_FILES = $(wildcard *.m)
EzFieldTest_LDFLAGS += /opt/projects/EzFieldTest/Frameworks/ControlCenterUIKit.tbd
EzFieldTest_INSTALL_PATH = /Library/ControlCenter/Bundles/

include $(THEOS_MAKE_PATH)/bundle.mk
