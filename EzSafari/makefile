include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = EzSafari
EzSafari_BUNDLE_EXTENSION = bundle
EzSafari_CFLAGS +=  -fobjc-arc -I$(THEOS)/include
EzSafari_ADDITIONAL_FRAMEWORKS = ControlCenterUIKit
EzSafari_FILES = $(wildcard *.m)
EzSafari_LDFLAGS += /opt/projects/EzSafari/Frameworks/ControlCenterUIKit.tbd
EzSafari_INSTALL_PATH = /Library/ControlCenter/Bundles/

include $(THEOS_MAKE_PATH)/bundle.mk
