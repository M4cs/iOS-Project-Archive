include $(THEOS)/makefiles/common.mk

SDKVERSION=9.2 
SYSROOT=$(THEOS)/sdks/iPhoneOS9.2.sdk

BUNDLE_NAME = darkSwitcherPrefs
darkSwitcherPrefs_FILES = DarkSwitcherPrefs.m
darkSwitcherPrefs_INSTALL_PATH = /Library/PreferenceBundles
darkSwitcherPrefs_FRAMEWORKS = UIKit
darkSwitcherPrefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/darkSwitcherPrefs.plist$(ECHO_END)
