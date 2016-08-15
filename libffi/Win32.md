# Configuring libffi for Win32

First steps: ensure that the Visual Studio compiler variables have been declared (e.g. via the Visual Studio Command Line shortcut) and that you are running in a Cygwin or Mingw32/Mingw64 shell.

To configure libffi for win32, use a command line like the following:


	./configure CC="$(pwd)/msvcc.sh -m64 -DUSE_STATIC_RTL" LD="link" CPP="cl -nologo -EP" --build=x86_64-pc-mingw64

(for 32-bit builds, remove the "-m64" flag)

Next, remove the symlink that was created by the configure step and replace it with a copy:

	rm x86_64-pc-mingw64/include/ffitarget.h
	cp src/x86/ffitarget.h x86_64-pc-mingw64/include/

Run the build. Failures don't matter here; we just want one file in particular to be pre-processed correctly:

	cd x86_64-pc-mingw64
	make -k

Copy the headers to the pre-configured header directory:

	cp fficonfig.h ${thirdparty_repo}/libffi/include_win32/x86_64/
	cp include/ffi{,target}.h ${thirdparty_repo}/libffi/include_win32/x86_64/
	cp ../include/ffi_common.h ${thirdparty_repo}/libffi/include_win32/x86_64/

Copy the pre-processed assembly file to the correct location (this will be win32.asm for 32-bit targets):

	cp src/x86/.libs/win64.asm ${thirdparty_repo}/libffi/src/x86/

The rest of the source files required for x86 can be copied into the shared source folder as normal:

	cp ../src/x86/* ${thirdparty_repo}/libffi/src/x86

