@echo off
REM This file requires that the execution environment is set up as follows:
REM	Cygwin is in PATH
REM	MSVC is in PATH
REM	INCLUDE and LIB point to the Windows SDK
REM
REM It is also assumed that the ICU source has been unpacked in the current directory
REM (i.e. ./icu/source/runConfigureICU is the path to the configure script)

set LOCATION=%CD%
mkdir build-win32
mkdir build-win32\i386
cd    build-win32\i386

bash ../../icu/source/runConfigureICU Cygwin/MSVC --prefix=/ --with-data-packaging=archive --disable-samples --disable-tests

REM Unfortunately, the following defines do not work properly for Win32 builds but
REM are used by the build scripts for the other platforms. This shouldn't make
REM anything break for Win32 but it makes it a bit less strict for some checks
REM
REM	-DU_USING_ICU_NAMESPACE=0
REM	-DUNISTR_FROM_CHAR_EXPLICIT=explicit
REM	-DUNISTR_FROM_STRING_EXPLICIT=explicit

make

REM Install the files to the staging location
bash -c "make DESTDIR=`pwd`/platforms/win32/i386 install"
cp -r platforms/win32/i386 ../../platforms/win32/i386

REM Restore the original directory
cd %LOCATION%
