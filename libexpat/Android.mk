LOCAL_PATH:= $(call my-dir)

# We need to build this for both the device (as a shared library)
# and the host (as a static library for tools to use).

common_SRC_FILES := \
	lib/xmlparse.c \
	lib/xmlrole.c \
	lib/xmltok.c

common_CFLAGS := \
    -Wall \
    -Wmissing-prototypes -Wstrict-prototypes \
    -Wno-unused-parameter -Wno-missing-field-initializers \
    -fexceptions \
    -DHAVE_EXPAT_CONFIG_H

common_C_INCLUDES += \
	$(LOCAL_PATH)/lib

common_COPY_HEADERS_TO := libexpat
common_COPY_HEADERS := \
	lib/expat.h \
	lib/expat_external.h


# For the device
# =====================================================

# Device static library
include $(CLEAR_VARS)

ifeq ($(TARGET_ARCH),arm)
LOCAL_SDK_VERSION := 8
endif

LOCAL_SRC_FILES := $(common_SRC_FILES)
LOCAL_CFLAGS += $(common_CFLAGS)
LOCAL_C_INCLUDES += $(common_C_INCLUDES)

LOCAL_MODULE:= libexpat_static
LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/Android.mk
LOCAL_MODULE_TAGS := optional

include $(BUILD_STATIC_LIBRARY)
