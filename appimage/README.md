# brigadachat AppImage

brigadachat is provided as AppImage too. To Download, visit brigadachat.im.

## Building

- Ensure you install `appimagetool`

```shell
flutter build linux

# copy binaries to appimage dir
cp -r build/linux/{x64,arm64}/release/bundle appimage/brigadachat.AppDir
cd appimage

# prepare AppImage files
cp brigadachat.desktop brigadachat.AppDir/
mkdir -p brigadachat.AppDir/usr/share/icons
cp ../assets/logo.svg brigadachat.AppDir/brigadachat.svg
cp AppRun brigadachat.AppDir

# build the AppImage
appimagetool brigadachat.AppDir
```
