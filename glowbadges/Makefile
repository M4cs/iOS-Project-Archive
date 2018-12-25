export ARCHS = arm64 armv7 armv7s

include theos/makefiles/common.mk

TWEAK_NAME = GlowBadge
GlowBadge_FILES = Tweak.xm UIImage-DominantColor/UIImage+DominantColor.m
GlowBadge_FRAMEWORKS = UIKit QuartzCore CoreGraphics

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += Preferences
include /theos/makefiles/aggregate.mk
