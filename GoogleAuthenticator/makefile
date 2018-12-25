include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = EzGoogleAuthenticator
EzGoogleAuthenticator_BUNDLE_EXTENSION = bundle
EzGoogleAuthenticator_CFLAGS +=  -fobjc-arc -I$(THEOS)/include
EzGoogleAuthenticator_ADDITIONAL_FRAMEWORKS = ControlCenterUIKit
EzGoogleAuthenticator_FILES = $(wildcard *.m)
EzGoogleAuthenticator_LDFLAGS += /opt/projects/GoogleAuthenticator/Frameworks/ControlCenterUIKit.tbd
EzGoogleAuthenticator_INSTALL_PATH = /Library/ControlCenter/Bundles/

include $(THEOS_MAKE_PATH)/bundle.mk
