# Steps for updating CEF

- Go to http://opensource.spotify.com/cefbuilds/index.html
- Download the latest standard distribution for Windows or Linux and extract
- Delete `thirdparty/libcef/include` and `thirdparty/libcef/libcef_dll`
- Copy `include` and `libcef_dll` from the CEF build to `thirdparty/libcef`
- CD to `thirdparty/libcef`
- Execute `python gen_libcef_paths.py libcef_dll > libcef.gypi`
- Execute `python gen_libcef_stubs.py include > libcef.stubs`
- Stderr will list unknown parameter or return types so edit `gen_libcef_stubs.py`
to add them and run again
- Copy binaries and resources from the CEF build to the prebuilt folders checking
for any new file names to update in the gyp files and prebuild builder. Note copy
the binaries from the Release folder even to the debug prebuilt folders.
- Reconfigure and build
- Fix any API changes and make sure things work
- Update `prebuilt/versions/cef` and `prebuilt/versions/cef_buildrevision`
- Push up a patch to livecode and thirdparty
- Kick off prebuilts
