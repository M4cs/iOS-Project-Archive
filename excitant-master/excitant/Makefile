include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = ExcitantPrefs
ExcitantPrefs_FILES = EXCRootListController.m SBRootListController.m TouchesRootListController.m SwitchRootListController.m HomeHijackController.m VolumeController.m
ExcitantPrefs_INSTALL_PATH = /Library/PreferenceBundles
ExcitantPrefs_FRAMEWORKS = UIKit
ExcitantPrefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/Excitant.plist$(ECHO_END)
