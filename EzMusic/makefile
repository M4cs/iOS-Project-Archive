include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = EzMusic
EzMusic_BUNDLE_EXTENSION = bundle
EzMusic_CFLAGS +=  -fobjc-arc -I$(THEOS)/include
EzMusic_ADDITIONAL_FRAMEWORKS = ControlCenterUIKit
EzMusic_FILES = $(wildcard *.m)
EzMusic_LDFLAGS += /opt/projects/EzMusic/Frameworks/ControlCenterUIKit.tbd
EzMusic_INSTALL_PATH = /Library/ControlCenter/Bundles/

include $(THEOS_MAKE_PATH)/bundle.mk
