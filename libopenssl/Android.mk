LOCAL_PATH := $(call my-dir)
OPENSSL_PATH := $(call my-dir)

#########

include $(CLEAR_VARS)

TARGET_PLATFORM=android-8

LOCAL_MODULE := openssl

LOCAL_C_INCLUDES := $(LOCAL_PATH)/include $(LOCAL_PATH)/src

LOCAL_SRC_FILES := src/sslstubs.android.cpp

SSLSTUBS := $(LOCAL_PATH)/src/sslstubs.android.cpp

$(SSLSTUBS): $(SRCROOT)/util/weak_stub_maker.pl $(OPENSSL_PATH)/ssl.stubs
#	$(SRCROOT)/prebuilt/bin/Revolution.osx $(SRCROOT)/tools/weak_stub_maker.lc < $(OPENSSL_PATH)/ssl.stubs > $(SSLSTUBS)
	$(SRCROOT)/util/weak_stub_maker.pl < $(OPENSSL_PATH)/ssl.stubs > $(SSLSTUBS)
.PHONY: $(SSLSTUBS)

include $(BUILD_STATIC_LIBRARY)

#########

include $(CLEAR_VARS)

TARGET_PLATFORM=android-8

LOCAL_MODULE := revsecurity

LOCAL_STATIC_LIBRARIES := $(PREBUILT_LIB_DIR)/libcustomcrypto.a $(PREBUILT_LIB_DIR)/libcustomssl.a

LOCAL_LDFLAGS += -Wl,--whole-archive $(LOCAL_STATIC_LIBRARIES) -Wl,-no-whole-archive -ldl -Wl,-soname,revsecurity.so

include $(BUILD_SHARED_LIBRARY)

#########
