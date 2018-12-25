include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = colorswitcherPrefs
colorswitcherPrefs_LIBRARIES = colorpicker
colorSwitcherPrefs_FILES = ColorSwitcherPrefs.m
colorSwitcherPrefs_INSTALL_PATH = /Library/PreferenceBundles
colorSwitcherPrefs_FRAMEWORKS = UIKit
colorSwitcherPrefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/colorswitcherPrefs.plist$(ECHO_END)
