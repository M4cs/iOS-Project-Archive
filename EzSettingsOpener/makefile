include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = EzSettings
EzSettings_BUNDLE_EXTENSION = bundle
EzSettings_CFLAGS +=  -fobjc-arc -I$(THEOS)/include
EzSettings_ADDITIONAL_FRAMEWORKS = ControlCenterUIKit
EzSettings_FILES = $(wildcard *.m)
EzSettings_LDFLAGS += /opt/projects/EzSettingsOpener/Frameworks/ControlCenterUIKit.tbd
EzSettings_INSTALL_PATH = /Library/ControlCenter/Bundles/

include $(THEOS_MAKE_PATH)/bundle.mk
