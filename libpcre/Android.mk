LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

TARGET_PLATFORM=android-8

LOCAL_MODULE := libpcre

LOCAL_ARM_MODE := arm

LOCAL_SRC_FILES := \
	$(addprefix src/, pcre_byte_order.c pcre_chartables.c pcre_compile.c pcre_config.c pcre_dfa_exec.c \
	pcre_exec.c pcre_fullinfo.c pcre_get.c pcre_globals.c pcre_info_fullinfo.c \
	pcre_jit_compile.c pcre_maketables.c pcre_newline.c pcre_ord2utf8.c pcre_refcount.c \
	pcre_string_utils.c pcre_study.c pcre_tables.c pcre_ucd.c pcre_valid_utf8.c \
	pcre_version.c pcre_xclass.c)

LOCAL_C_INCLUDES := \
	$(LOCAL_PATH)/include

include $(BUILD_STATIC_LIBRARY)
