include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = switcherPrefs
switcherPrefs_FILES = SPBRootListController.m
switcherPrefs_INSTALL_PATH = /Library/PreferenceBundles
switcherPrefs_FRAMEWORKS = UIKit
switcherPrefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/switcherPrefs.plist$(ECHO_END)
