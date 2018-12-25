include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = Prefs
Prefs_FILES = MotusPrefsRootListController.m
Prefs_INSTALL_PATH = /Library/PreferenceBundles
Prefs_FRAMEWORKS = UIKit
Prefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/Prefs.plist$(ECHO_END)
