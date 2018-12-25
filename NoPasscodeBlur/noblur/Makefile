include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = NoBlur
NoBlur_FILES = NBRootListController.mm NBBlurListController.mm NBIndividualListController.mm NBPreViewController.mm NBAppsListController.mm NBCustomizeListController.mm
NoBlur_INSTALL_PATH = /Library/PreferenceBundles
NoBlur_FRAMEWORKS = UIKit
NoBlur_PRIVATE_FRAMEWORKS = Preferences
NoBlur_LIBRARIES = applist

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/NoBlur.plist$(ECHO_END)
