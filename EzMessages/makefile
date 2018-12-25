include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = EzMessages
EzMessages_BUNDLE_EXTENSION = bundle
EzMessages_CFLAGS +=  -fobjc-arc -I$(THEOS)/include
EzMessages_ADDITIONAL_FRAMEWORKS = ControlCenterUIKit
EzMessages_FILES = $(wildcard *.m)
EzMessages_LDFLAGS += /opt/projects/EzMessages/Frameworks/ControlCenterUIKit.tbd
EzMessages_INSTALL_PATH = /Library/ControlCenter/Bundles/

include $(THEOS_MAKE_PATH)/bundle.mk
