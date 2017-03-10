#if defined(_LINUX)
#include "config-lnx.h"
#elif defined(TARGET_PLATFORM_MACOS)
#include "config-osx.h"
#elif defined(TARGET_SUBPLATFORM_IPHONE)
#include "config-ios.h"
#elif defined(TARGET_SUBPLATFORM_ANDROID)
#include "config-android.h"
#endif
