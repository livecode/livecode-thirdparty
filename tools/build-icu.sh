#!/bin/bash

THIS_DIR=`pwd`
ICU_PATH="${THIS_DIR}/icu"
ICU_VERSION=52.1

# Grab the specified version of the ICU library
if [ ! -d "${ICU_PATH}" ] ; then
	ICU_VERSION_ALT=$(echo "${ICU_VERSION}" | sed 's/\./_/g')
	wget "http://download.icu-project.org/files/icu4c/${ICU_VERSION}/icu4c-${ICU_VERSION_ALT}-src.tgz"
	tar -xf "icu4c-${ICU_VERSION_ALT}-src.tgz"
fi

# iOS and OSX SDKs location
PLATFORMS_DIR="${HOME}/Builds/Platforms"

# Android NDK options
ANDROID_NDK="${HOME}/SDKs/android/ndk-r5c"
ANDROID_SYSROOT="${ANDROID_NDK}/platforms/android-9/arch-arm"
ANDROID_BIN="${ANDROID_NDK}/toolchains/arm-linux-androideabi-4.4.3/prebuilt/darwin-x86/bin"
ANDROID_ARMV7="-march=armv7-a -mfloat-abi=softfp -mfpu=neon"
ANDROID_ARMV6=""
ANDROID_ARMV5="-mfpu=vfp"

CONFIG_COMMON="--disable-shared --enable-static --prefix=/ --with-data-packaging=archive --disable-samples --disable-tests"
CFLAGS_COMMON="-DU_USING_ICU_NAMESPACE=0 -DUNISTR_FROM_CHAR_EXPLICIT=explicit -DUNISTR_FROM_STRING_EXPLICIT=explicit"

# Set some default makeflags. Will be overridden by explicitly-set makeflags
MAKEFLAGS=${MAKEFLAGS:-"-j4"}

# Don't overwrite the user's CFLAGS if possible
OLD_CFLAGS="${CFLAGS}"
OLD_CXXFLAGS="${CXXFLAGS}"
OLD_LDFLAGS="${LDFLAGS}"

# Choose the optimisation settings based on the MODE variable
if [ -z "${MODE}" -o "${MODE}" = "Release" ] ; then
	CFLAGS=${CFLAGS:-"-O3 -g0 -DNDEBUG"}
elif [ "${MODE}" = "Debug" ] ; then
	CFLAGS=${CFLAGS:-"-O0 -g3"}
else
	echo "The "MODE" variable should be set to either Debug or Release"
	exit
fi
	

SCRIPT="$0"
PLATFORM="$1"
ARCH="$2"
SDK="$3"
TARGET="$4"
VERSION="$5"

INSTALL_ROOT="${THIS_DIR}/platforms"
INSTALL_DIR="${INSTALL_ROOT}/${PLATFORM}/${ARCH}/${TARGET}/${VERSION}"

# If we're doing an iOS build, auto-detect and build the various combinations
if [ $# -eq 1 -a $1 = "ios" ] ; then
	# Ensure that the osx version is already built
	if [ ! -d "${THIS_DIR}/build-osx-i386" ] ; then
		$SCRIPT osx i386
	fi

	VERSIONS=""
	# Build against the iOS4.3 simulator if present
	if [ -e $PLATFORMS_DIR/Xcode_3_2_6 ] ; then
		echo " ***** Building for iOS 4.3 ***** "
		$SCRIPT ios i386 $PLATFORMS_DIR/Xcode_3_2_6 iPhoneSimulator 4.3
		VERSIONS+=" 4.3"
	fi
	# Build against the iOS5.0 SDK if present
	if [ -e $PLATFORMS_DIR/Xcode_4_2_0 ] ; then
		echo " ***** Building for iOS 5.0 ***** "
		$SCRIPT ios i386  $PLATFORMS_DIR/Xcode_4_2_0 iPhoneSimulator 5.0
		$SCRIPT ios armv7 $PLATFORMS_DIR/Xcode_4_2_0 iPhoneOS 5.0
		VERSIONS+=" 5.0"
	fi
	# Build against the iOS5.1 SDK if present
	if [ -e $PLATFORMS_DIR/Xcode_4_3_1 ] ; then
		echo " ***** Building for iOS 5.1 ***** "
		$SCRIPT ios i386  $PLATFORMS_DIR/Xcode_4_3_1/Xcode.app/Contents/Developer iPhoneSimulator 5.1
		$SCRIPT ios armv7 $PLATFORMS_DIR/Xcode_4_3_1/Xcode.app/Contents/Developer iPhoneOS 5.1
		VERSIONS+=" 5.1"
	fi
	# Build against the iOS6.0 SDK if present
	if [ -e $PLATFORMS_DIR/Xcode_4_5_0 ] ; then
		echo " ***** Building for iOS 6.0 ***** "
		$SCRIPT ios i386  $PLATFORMS_DIR/Xcode_4_5_0/Xcode.app/Contents/Developer iPhoneSimulator 6.0
		$SCRIPT ios armv7 $PLATFORMS_DIR/Xcode_4_5_0/Xcode.app/Contents/Developer iPhoneOS 6.0
		VERSIONS+=" 6.0"
	fi
	# Build against the iOS6.1 SDK if present
	if [ -e $PLATFORMS_DIR/Xcode_4_6_0 ] ; then
		echo " ***** Building for iOS 6.1 ***** "
		$SCRIPT ios i386  $PLATFORMS_DIR/Xcode_4_6_0/Xcode.app/Contents/Developer iPhoneSimulator 6.1
		$SCRIPT ios armv7 $PLATFORMS_DIR/Xcode_4_6_0/Xcode.app/Contents/Developer iPhoneOS 6.1
		VERSIONS+=" 6.1"
	fi
	# Build against the iOS7.0 SDK if present
	if [ -e $PLATFORMS_DIR/Xcode_5_0_0 ] ; then
		echo " ***** Building for iOS 7.0 ***** "
		$SCRIPT ios i386  $PLATFORMS_DIR/Xcode_5_0_0/Xcode.app/Contents/Developer iPhoneSimulator 7.0
		$SCRIPT ios armv7 $PLATFORMS_DIR/Xcode_5_0_0/Xcode.app/Contents/Developer iPhoneOS 7.0
		$SCRIPT ios arm64 $PLATFORMS_DIR/Xcode_5_0_0/Xcode.app/Contents/Developer iPhoneOS 7.0
		VERSIONS+=" 7.0"
	fi

	# Combine the iOS device and simulator libraries into multi-arch files
	for V in ${VERSIONS} ; do
		for T in iPhoneOS iPhoneSimulator ; do
			mkdir -p "${INSTALL_ROOT}/ios/universal/${T}/${V}/lib"
			for L in libicu{data,i18n,io,le,lx,tu,uc}.a ; do
				LIBS=""
				for A in armv6 armv7 armv7s arm64 i386 ; do
					if [ -e "${INSTALL_ROOT}/ios/${A}/${T}/${V}/lib/${L}" ] ; then
						LIBS+=" ${INSTALL_ROOT}/ios/${A}/${T}/${V}/lib/${L}"
					fi
				done
				if [ "${LIBS}" ] ; then
					lipo -create ${LIBS} -output "${INSTALL_ROOT}/ios/universal/${T}/${V}/lib/${L}"
				fi
			done
		done
	done

	# All done
	exit
fi

# If we're doing a universal OSX build, do that now
if [ $# -eq 1 -a $1 = "osx" ] ; then
	for A in i386 ppc ; do
		$SCRIPT osx $A
	done

	# Combine the various built OSX libraries
	mkdir -p "${INSTALL_ROOT}/osx/universal/lib"
	for L in libicu{data,i18n,io,le,lx,tu,uc}.${ICU_VERSION}.a ; do
		LIBS=""
		for A in ppc ppc64 i386 x86_64 ; do
			if [ -e "${INSTALL_ROOT}/osx/${A}/lib/${L}" ] ; then
				LIBS+=" ${INSTALL_ROOT}/osx/${A}/lib/${L}"
			fi
		done
		if [ "${LIBS}" ] ; then
			lipo -create ${LIBS} -output "${INSTALL_ROOT}/osx/universal/lib/${L}"
		fi
	done

	# Do the same for the binary utilities
	mkdir -p "${INSTALL_ROOT}/osx/universal/bin"
	for B in derb genbrk gencfu gencnval gendict genrb icuinfo makeconv pkgdata uconv ; do
		BINS=""
		for A in ppc ppc64 i386 x86_64 ; do
			if [ -e "${INSTALL_ROOT}/osx/${A}/bin/${B}" ] ; then
				BINS+=" ${INSTALL_ROOT}/osx/${A}/bin/${B}"
			fi
		done
		if [ "${BINS}" ] ; then
			lipo -create ${BINS} -output "${INSTALL_ROOT}/osx/universal/bin/${B}"
		fi
	done

	exit
fi

# Need to specify a platform
if [ $# != 2  -a $# != 5 ] ; then
	echo "Usage:"
	echo "./build-icu.sh <platform> <architecture>"
	echo "./build-icu.sh osx"
	echo "./build-icu.sh ios <architecture> <xcode-sdk> <target> <version>"
	echo 
	echo "Where <platform> = ios osx linux android"
	echo "Officially supported platform-architecture combinations are:"
	echo "    ios osx-i386 osx-ppc linux-i386 android-armv6"
	echo
	echo "When <platform> = ios, installed SDKs will be located and the appropriate"
	echo "simulator and device variants of each will be built. Additionally, the"
	echo "osx-i386 variant will be built first as it is needed to cross-compile."
	echo
	echo "When <platform> = osx and no architecture is supplied, it is equivalent"
	echo "to invoking with each of the supported osx architectures individually"
	echo "but with the added feature of building multi-arch dylibs."
	exit
fi

# Create a directory to build the library in
if [ $# == 5 ] ; then
	BUILD_DIR="${THIS_DIR}/build-${PLATFORM}/${ARCH}-${TARGET}-${VERSION}"
else
	BUILD_DIR="${THIS_DIR}/build-${PLATFORM}/${ARCH}"
fi
if [ ! -d $BUILD_DIR ] ; then
	mkdir -p "${BUILD_DIR}"
fi
cd ${BUILD_DIR}
HOST_BUILD_DIR="${THIS_DIR}/build-osx/i386"

# Which platform are we building for?
TRIPLET=${PLATFORM}-${ARCH}
case ${TRIPLET} in
	ios-*)
		# Make sure to use the compiler from the iOS SDK
		if [ -e "${SDK}/Platforms/${TARGET}.platform/Developer/usr/bin/gcc" ] ; then
			CC="${SDK}/Platforms/${TARGET}.platform/Developer/usr/bin/gcc"
			CXX="${SDK}/Platforms/${TARGET}.platform/Developer/usr/bin/g++"
		elif [ -e "${SDK}/usr/bin/gcc" ] ; then
			CC="${SDK}/usr/bin/gcc"
			CXX="${SDK}/usr/bin/g++"
		fi

		SYSROOT=${SDK}/Platforms/${TARGET}.platform/Developer/SDKs/${TARGET}${VERSION}.sdk
		export CFLAGS="${CFLAGS} -arch ${ARCH} -isysroot ${SYSROOT}"
		export LDFLAGS="-L${SYSROOT}/usr/lib -isysroot ${SYSROOT} -Wl,-dead_strip"
		CONFIG_EXTRA="--host=arm-apple-darwin --with-cross-build=${HOST_BUILD_DIR} --disable-tools"

		# When building for the iOS simulator for iOS 7.0, the compiler thinks it is building for OSX
		if [ "${VERSION}" == "7.0" ] ; then
			CFLAGS+=" -mios-min-version=4.3"
		fi
		;;

	osx-ppc|osx-ppc64)
		# PowerPC is only supported as a cross-compile target.
		# ICU 52.1 also requires the 10.5 SDK to build
		CONFIG_FLAGS="MacOSX --host=${ARCH}-apple-darwin --with-cross-build=${HOST_BUILD_DIR}"
		CC="${PLATFORMS_DIR}/Xcode_3_2_6/usr/bin/gcc"
		CXX="${PLATFORMS_DIR}/Xcode_3_2_6/usr/bin/g++"
		export CFLAGS="${CFLAGS} -arch ${ARCH} -isysroot ${PLATFORMS_DIR}/Xcode_3_2_6/SDKs/MacOSX10.5.sdk -mmacosx-version-min=10.4"
		LDFLAGS="-L${PLATFORMS_DIR}/Xcode_3_2_6/usr/lib"
		;;

	osx-i386|osx-x86_64)
		CONFIG_FLAGS="MacOSX"
		export CFLAGS="-arch ${ARCH}"
		if [ "${TRIPLET}" = "osx-x86_64" ] ; then
			CONFIG_FLAGS+=" --with-library-bits=64"
		else
			CONFIG_FLAGS+=" --with-library-bits=32"
		fi
		;;

	linux-*)
		# As CC and CXX are not set, the user values are honoured on Linux
		CONFIG_FLAGS="Linux"
		case ${ARCH} in
			*64)
				CONFIG_FLAGS+=" --with-library-bits=64"
				;;

			*)
				CONFIG_FLAGS+=" --with-library-bits=32"
				;;
		esac
		;;

	android-*)
		# Android native builds are configured as a Linux cross-compile
		CONFIG_FLAGS="Linux --host=arm-linux-androideabi --with-cross-build=${HOST_BUILD_DIR} --disable-tools"
		CCOPTIONS="--sysroot ${ANDROID_SYSROOT} -fpic -ffunction-sections -funwind-tables -Wno-psabi -mthumb -fomit-frame-pointer -fno-strict-aliasing -DANDROID -Wa,--noexecstack"
		CC="${ANDROID_BIN}/arm-linux-androideabi-gcc ${CCOPTIONS}"
		CXX="${ANDROID_BIN}/arm-linux-androideabi-g++ ${CCOPTIONS}"

		# Do some path juggling to keep the configure script happy
		OLDPATH="${PATH}"
		export PATH="${PATH}:${ANDROID_BIN}"

		# Only a subset of possible Android architectures are supported for builds
		STL="${ANDROID_NDK}/sources/cxx-stl/gnu-libstdc++"
		if [ "${ARCH}" = "armv6" ] ; then
			CFLAGS+=" ${ANDROID_ARMV6}"
			ARCH_STL="${STL}/libs/armeabi"
		elif [ "${ARCH}" = "armv7" ] ; then
			CFLAGS+=" ${ANDROID_ARMV7}"
			ARCH_STL="${STL}/libs/armeabi-v7a"
		else
			echo "Android only supported for armv6 and armv7 architectures"
			exit
		fi

		# Some extra CFLAGS are needed in order to compile properly
		# In particular, ICU uses RTTI and needs to use the GNU C++ library rather than STLPort
		export CFLAGS="${CFLAGS} -D__STDC_INT64__ -DU_HAVE_NL_LANGINFO_CODESET=0 -isystem${STL}/include -isystem${ARCH_STL}/include"
		LDFLAGS="-Wl,--fix-cortex-a8 -Wl,--no-undefined -Wl,-z,noexecstack -L${ARCH_STL}"

		;;
esac

export CXXFLAGS="${CFLAGS}"

if [ "${CONFIG_FLAGS}" ] ; then

CC="${CC}" CXX="${CXX}" LDFLAGS="${LDFLAGS}" "${ICU_PATH}/source/runConfigureICU" ${CONFIG_FLAGS} ${CONFIG_COMMON}

else

CC="${CC}" CXX="${CXX}" LDFLAGS="${LDFLAGS}" "${ICU_PATH}/source/configure" ${CONFIG_COMMON} ${CONFIG_EXTRA}


fi

CFLAGS="${CFLAGS} ${CFLAGS_COMMON}" make $MAKEFLAGS
make DESTDIR="${INSTALL_DIR}" install

# Restore the old CFLAGS
export CFLAGS="${OLD_CFLAGS}"
export CXXFLAGS="${OLD_CXXFLAGS}"
export LDFLAGS="${OLD_LDFLAGS}"

if [ -n "${OLDPATH}" ] ; then
	export PATH="${OLDPATH}"
fi

