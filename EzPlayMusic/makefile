include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = EzPlayMusic
EzPlayMusic_BUNDLE_EXTENSION = bundle
EzPlayMusic_CFLAGS +=  -fobjc-arc -I$(THEOS)/include
EzPlayMusic_ADDITIONAL_FRAMEWORKS = ControlCenterUIKit
EzPlayMusic_FILES = $(wildcard *.m)
EzPlayMusic_LDFLAGS += /opt/projects/EzPlayMusic/Frameworks/ControlCenterUIKit.tbd
EzPlayMusic_INSTALL_PATH = /Library/ControlCenter/Bundles/

include $(THEOS_MAKE_PATH)/bundle.mk
