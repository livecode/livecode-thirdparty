LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

TARGET_PLATFORM=android-8

LOCAL_MODULE := libpcre

LOCAL_ARM_MODE := arm

LOCAL_SRC_FILES := \
	$(addprefix src/, pcre16_byte_order.c pcre16_chartables.c pcre16_compile.c pcre16_config.c pcre16_dfa_exec.c \
	pcre16_exec.c pcre16_fullinfo.c pcre16_get.c pcre16_globals.c pcre_info_fullinfo.c \
	pcre16_jit_compile.c pcre16_maketables.c pcre16_newline.c pcre16_ord2utf16.c pcre16_refcount.c \
	pcre16_string_utils.c pcre16_study.c pcre16_tables.c pcre16_ucd.c pcre16_valid_utf16.c \
	pcre16_version.c pcre16_xclass.c)

LOCAL_C_INCLUDES := \
	$(LOCAL_PATH)/include

LOCAL_CFLAGS += -DHAVE_CONFIG_H

include $(BUILD_STATIC_LIBRARY)
