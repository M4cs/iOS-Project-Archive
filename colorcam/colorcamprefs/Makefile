include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = ColorCamPrefs
ColorCamPrefs_FILES = CCPRootListController.m
ColorCamPrefs_INSTALL_PATH = /Library/PreferenceBundles
ColorCamPrefs_FRAMEWORKS = UIKit
ColorCamPrefs_PRIVATE_FRAMEWORKS = Preferences
ColorCamPrefs_LIBRARIES = colorpicker

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/ColorCamPrefs.plist$(ECHO_END)
