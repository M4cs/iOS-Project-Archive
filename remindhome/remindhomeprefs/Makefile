include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = remindhomeprefs
remindhomeprefs_FILES = RHPRootListController.m
remindhomeprefs_INSTALL_PATH = /Library/PreferenceBundles
remindhomeprefs_FRAMEWORKS = UIKit
remindhomeprefs_PRIVATE_FRAMEWORKS = Preferences
remindhomeprefs_LIBRARIES = colorpicker

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/remindhomeprefs.plist$(ECHO_END)
