TARGET = iphone:9.2

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = PickPocket
PickPocket_FILES = Tweak.xm AYVibrantButton/AYVibrantButton.m MLIMGURUploader/MLIMGURUploader.m Reachability/Reachability.m libfireball/libfireball.m
PickPocket_FRAMEWORKS = AVFoundation AudioToolbox CoreTelephony MessageUI IOKit
PickPocket_PRIVATE_FRAMEWORKS = Celestial
PickPocket_LIBRARIES = Cephei flipswitch
PickPocket_LDFLAGS = -lcolorpicker

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += pickpocket
include $(THEOS_MAKE_PATH)/aggregate.mk
