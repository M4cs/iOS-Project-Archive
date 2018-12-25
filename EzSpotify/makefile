include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = EzSpotify
EzSpotify_BUNDLE_EXTENSION = bundle
EzSpotify_CFLAGS +=  -fobjc-arc -I$(THEOS)/include
EzSpotify_ADDITIONAL_FRAMEWORKS = ControlCenterUIKit
EzSpotify_FILES = $(wildcard *.m)
EzSpotify_LDFLAGS += /opt/projects/EzSpotify/Frameworks/ControlCenterUIKit.tbd
EzSpotify_INSTALL_PATH = /Library/ControlCenter/Bundles/

include $(THEOS_MAKE_PATH)/bundle.mk
