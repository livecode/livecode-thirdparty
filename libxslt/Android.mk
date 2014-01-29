LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

TARGET_PLATFORM=android-8

LOCAL_MODULE := libxslt

LOCAL_SRC_FILES := \
	$(addprefix src/,attributes.c attrvt.c documents.c extensions.c \
	functions.c imports.c keys.c namespaces.c security.c \
	numbers.c pattern.c preproc.c templates.c transform.c \
	variables.c xslt.c xsltlocale.c xsltutils.c extra.c)

LOCAL_C_INCLUDES := \
	$(LOCAL_PATH)/include/libxslt \
	$(LOCAL_PATH)/include \
	$(LOCAL_PATH)/../libxml/include

include $(BUILD_STATIC_LIBRARY)
