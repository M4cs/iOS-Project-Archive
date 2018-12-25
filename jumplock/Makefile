include $(THEOS)/makefiles/common.mk

TWEAK_NAME = NestedFolders11
NestedFolders11_FILES = Tweak.xm
NestedFolders11_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
