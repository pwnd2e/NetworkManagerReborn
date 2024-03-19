ARCHS = arm64

export TARGET = iphone:latest:14.0
export THEOS=/theos
INSTALL_TARGET_PROCESSES = SpringBoard


include $(THEOS)/makefiles/common.mx



BUNDLE_NAME = NetworkManager
NetworkManager_BUNDLE_EXTENSION = bundle
NetworkManager_FILES = CCNetworkManager.x
NetworkManager_FRAMEWORKS = CoreTelephony
NetworkManager_PRIVATE_FRAMEWORKS = ControlCenterUIKit
NetworkManager_INSTALL_PATH = /Library/ControlCenter/Bundles/

NetworkManager_CFLAGS += "-Wno-unused-function"
NetworkManager_CFLAGS += "-Wno-unused-variable"

after-install::
	install.exec "killall -9 SpringBoard"

include $(THEOS_MAKE_PATH)/bundle.mk
SUBPROJECTS += networkmanagerprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
