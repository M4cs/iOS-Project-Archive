include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = EzCydiaOpener
EzCydiaOpener_BUNDLE_EXTENSION = bundle
EzCydiaOpener_CFLAGS +=  -fobjc-arc -I$(THEOS)/include
EzCydiaOpener_ADDITIONAL_FRAMEWORKS = ControlCenterUIKit
EzCydiaOpener_FILES = $(wildcard *.m)
EzCydiaOpener_LDFLAGS += /opt/projects/ezcydiaopener/Frameworks/ControlCenterUIKit.tbd
EzCydiaOpener_INSTALL_PATH = /Library/ControlCenter/Bundles/

include $(THEOS_MAKE_PATH)/bundle.mk
