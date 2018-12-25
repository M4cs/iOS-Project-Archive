include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = TapTapUtilsPrefs
TapTapUtilsPrefs_FILES = TTXRootListController.m
TapTapUtilsPrefs_INSTALL_PATH = /Library/PreferenceBundles
TapTapUtilsPrefs_FRAMEWORKS = UIKit
TapTapUtilsPrefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/TapTapUtilsPrefs.plist$(ECHO_END)
