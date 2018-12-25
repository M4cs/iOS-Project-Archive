include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = EzDiscord
EzDiscord_BUNDLE_EXTENSION = bundle
EzDiscord_CFLAGS +=  -fobjc-arc -I$(THEOS)/include
EzDiscord_ADDITIONAL_FRAMEWORKS = ControlCenterUIKit
EzDiscord_FILES = $(wildcard *.m)
EzDiscord_LDFLAGS += /opt/projects/EzDiscord/Frameworks/ControlCenterUIKit.tbd
EzDiscord_INSTALL_PATH = /Library/ControlCenter/Bundles/

include $(THEOS_MAKE_PATH)/bundle.mk
