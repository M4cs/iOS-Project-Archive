include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = EzSnapchatOpener
EzSnapchatOpener_BUNDLE_EXTENSION = bundle
EzSnapchatOpener_CFLAGS +=  -fobjc-arc -I$(THEOS)/include
EzSnapchatOpener_ADDITIONAL_FRAMEWORKS = ControlCenterUIKit
EzSnapchatOpener_FILES = $(wildcard *.m)
EzSnapchatOpener_LDFLAGS += /opt/projects/EzSnapchatLauncher/Frameworks/ControlCenterUIKit.tbd
EzSnapchatOpener_INSTALL_PATH = /Library/ControlCenter/Bundles/

include $(THEOS_MAKE_PATH)/bundle.mk
