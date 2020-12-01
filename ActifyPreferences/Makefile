ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = ActifyPreferences

ActifyPreferences_FILES = $(wildcard ObjC/*.m)
ActifyPreferences_INSTALL_PATH = /Library/PreferenceBundles
ActifyPreferences_PRIVATE_FRAMEWORKS = Preferences
ActifyPreferences_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/ActifyPreferences.plist$(ECHO_END)