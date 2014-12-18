##
## Copyright (C) 2012 The Android Open Source Project
##
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
##      http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.
##

LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

FFI_SRC_FILES = \
	android/src/closures.c \
	android/src/debug.c \
	android/src/java_raw_api.c \
	android/src/prep_cif.c \
	android/src/raw_api.c \
	android/src/types.c \
	android/src/aarch64/ffi_arm64.c \
	android/src/aarch64/sysv_arm64.S \
	android/src/arm/ffi_arm.c \
	android/src/arm/sysv_arm.S \
	android/src/arm/trampoline_arm.S

#############################################################
#   build the ffi static library
#

TARGET_PLATFORM=android-8

LOCAL_MODULE:= libffi

LOCAL_ARM_MODE := arm

LOCAL_SRC_FILES:= \
	$(FFI_SRC_FILES)

LOCAL_CPP_EXTENSION     := .cc

LOCAL_C_INCLUDES        := \
  $(LOCAL_PATH)/android/include
  
LOCAL_CFLAGS += -DHB_NO_MT -DHAVE_OT -DHAVE_UCDN -DHAVE_FREETYPE
LOCAL_EXPORT_LDLIBS := -L$(LOCAL_PATH)/../prebuilt/lib/android/armv6 -licui18n -licuio -licule -liculx -licuuc -licudata

include $(BUILD_STATIC_LIBRARY)

