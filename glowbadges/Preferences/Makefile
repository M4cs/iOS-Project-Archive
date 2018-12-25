include theos/makefiles/common.mk

ADDITIONAL_OBJCFLAGS=-fobjc-arc

BUNDLE_NAME = GlowBadge
GlowBadge_FILES = GlowBadge.mm HeaderCell.mm ThanksCell.mm thanks/TTTAttributedLabel.m
GlowBadge_INSTALL_PATH = /Library/PreferenceBundles
GlowBadge_FRAMEWORKS = UIKit CoreText CoreGraphics QuartzCore
GlowBadge_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/GlowBadge.plist$(ECHO_END)
