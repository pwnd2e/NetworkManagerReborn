ARCHS = arm64

export TARGET = iphone:latest:14.0
export THEOS=/theos
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk


BUNDLE_NAME = NetworkManagerPrefs

NetworkManagerPrefs_FILES = CCNMRootListController.m
NetworkManagerPrefs_INSTALL_PATH = /Library/PreferenceBundles
NetworkManagerPrefs_FRAMEWORKS = UIKit
NetworkManagerPrefs_PRIVATE_FRAMEWORKS = Preferences
NetworkManagerPrefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/NetworkManagerPrefs.plist$(ECHO_END)
