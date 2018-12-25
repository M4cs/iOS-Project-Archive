include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = ColorMyCC
ColorMyCC_FILES = cmcRootListController.m
ColorMyCC_INSTALL_PATH = /Library/PreferenceBundles
ColorMyCC_FRAMEWORKS = UIKit
ColorMyCC_PRIVATE_FRAMEWORKS = Preferences
ColorMyCC_LIBRARIES = colorpicker



include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/ColorMyCC.plist$(ECHO_END)
