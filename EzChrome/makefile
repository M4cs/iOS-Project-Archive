include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = EzChrome
EzChrome_BUNDLE_EXTENSION = bundle
EzChrome_CFLAGS +=  -fobjc-arc -I$(THEOS)/include
EzChrome_ADDITIONAL_FRAMEWORKS = ControlCenterUIKit
EzChrome_FILES = $(wildcard *.m)
EzChrome_LDFLAGS += /opt/projects/EzChrome/Frameworks/ControlCenterUIKit.tbd
EzChrome_INSTALL_PATH = /Library/ControlCenter/Bundles/

include $(THEOS_MAKE_PATH)/bundle.mk
