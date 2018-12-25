ARCHS := armv7s arm64

XXX_LDFLAGS += -Wl,-segalign,4000
ADDITIONAL_OBJCFLAGS = -fobjc-arc

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Slices
Slices_FILES = Model/SSKeychain/SSKeychain.m Model/GameCenterAccountManager.mm Model/AppGroupSlicer.mm Model/Expetelek/Expetelek.mm Tweak.xm Model/RawSlicer.mm Model/Slicer.mm Model/FolderMigrator.mm Model/SliceSetting.mm
Slices_FRAMEWORKS = Security UIKit
Slices_PRIVATE_FRAMEWORKS = GameKit BackBoardServices
Slices_LIBRARIES = MobileGestalt applist

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
SUBPROJECTS += slicespreferences
SUBPROJECTS += tutorial
include $(THEOS_MAKE_PATH)/aggregate.mk
