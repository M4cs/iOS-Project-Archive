TARGET = iphone:9.2

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = PickPocket
PickPocket_FILES = $(wildcard *.m)
PickPocket_INSTALL_PATH = /Library/PreferenceBundles
PickPocket_FRAMEWORKS = UIKit
PickPocket_PRIVATE_FRAMEWORKS = Preferences
PickPocket_LIBRARIES = CepheiPrefs Cephei colorpicker

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/PickPocket.plist$(ECHO_END)
