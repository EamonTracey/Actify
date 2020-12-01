ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TOOL_NAME = actify

actify_FILES = $(wildcard ObjC/*.m)
actify_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tool.mk