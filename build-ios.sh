#!/bin/bash

xcodebuild -project "platform/xcode/love.xcodeproj/" \
	-scheme love-ios \
	-configuration Release \
	-derivedDataPath "ios-build" \
	-destination 'generic/platform=iOS' \
	ONLY_ACTIVE_ARCH="NO" \
	CODE_SIGNING_ALLOWED="NO"

APP="ios-build/Build/Products/Release-iphoneos/Lovely Mobile Maker.app"
OPWD="$PWD"
rm "$APP/Assets.car"
plutil -convert xml1 "$APP/Info.plist"
xcrun --sdk iphoneos pngcrush -revert-iphone-optimizations -d "$APP/tmp-std" "$APP/iOS AppIcon"*
mv "$APP/tmp-std/"* "$APP"
rm -rf "$APP/tmp-std"
rm base.ipa 2> /dev/null
rm -rf ios-build/tmp 2> /dev/null
mkdir -p ios-build/tmp/Payload
cp -r "$APP" ios-build/tmp/Payload
cd ios-build/tmp/
zip -r base.ipa Payload
cp base.ipa "$OPWD/base.ipa"
cd ..
rm -rf tmp
