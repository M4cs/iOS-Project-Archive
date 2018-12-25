include $(THEOS)/makefiles/common.mk

TWEAK_NAME = TapTapUtils
TapTapUtils_FILES = Tweak.xm
TapTapUtils_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += taptaputilsprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
