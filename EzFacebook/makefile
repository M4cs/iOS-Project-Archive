include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = EzFacebook
EzFacebook_BUNDLE_EXTENSION = bundle
EzFacebook_CFLAGS +=  -fobjc-arc -I$(THEOS)/include
EzFacebook_ADDITIONAL_FRAMEWORKS = ControlCenterUIKit
EzFacebook_FILES = $(wildcard *.m)
EzFacebook_LDFLAGS += /opt/projects/EzFacebook/Frameworks/ControlCenterUIKit.tbd
EzFacebook_INSTALL_PATH = /Library/ControlCenter/Bundles/

include $(THEOS_MAKE_PATH)/bundle.mk
