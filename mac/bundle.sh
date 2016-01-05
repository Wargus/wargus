#!/bin/bash

if [ -z "$STRATAGUS" ]; then
    echo "You must tell me where the stratagus binary is located by setting the STRATAGUS variable!"
    exit 1
fi

STRATAGUS="$(cd "$(dirname "$STRATAGUS")" && pwd -P)/$(basename $STRATAGUS)"

cd "`dirname "$0"`"

# Create app bundle structure
rm -rf Wargus.app
mkdir -p Wargus.app/Contents/Resources
mkdir -p Wargus.app/Contents/MacOS

# Copy launchscript and info.plist
cp Info.plist Wargus.app/Contents/
cp launchscript.sh Wargus.app/Contents/MacOS

# Generate icons
mkdir wargus.iconset
sips -z 16 16     ../wargus.png --out wargus.iconset/icon_16x16.png
sips -z 32 32     ../wargus.png --out wargus.iconset/icon_16x16@2x.png
sips -z 32 32     ../wargus.png --out wargus.iconset/icon_32x32.png
sips -z 64 64     ../wargus.png --out wargus.iconset/icon_32x32@2x.png
sips -z 128 128   ../wargus.png --out wargus.iconset/icon_128x128.png
sips -z 256 256   ../wargus.png --out wargus.iconset/icon_128x128@2x.png
sips -z 256 256   ../wargus.png --out wargus.iconset/icon_256x256.png
sips -z 512 512   ../wargus.png --out wargus.iconset/icon_256x256@2x.png
sips -z 512 512   ../wargus.png --out wargus.iconset/icon_512x512.png
sips -z 1024 1024   ../wargus.png --out wargus.iconset/icon_512x512@2x.png
iconutil -c icns wargus.iconset
rm -R wargus.iconset
mv wargus.icns Wargus.app/Contents/Resources/

# Bundle resources
cp -R ../campaigns ../contrib ../maps ../scripts Wargus.app/Contents/Resources/

# Bundle binaries and their dependencies
rm -rf macdylibbundler
git clone https://github.com/auriamg/macdylibbundler
cd macdylibbundler
make
cd ..

cp ../build/wartool Wargus.app/Contents/MacOS
cp "$STRATAGUS" Wargus.app/Contents/MacOS/stratagus

macdylibbundler/dylibbundler -cd -of -b -x ./Wargus.app/Contents/MacOS/wartool -d ./Wargus.app/Contents/libs/

macdylibbundler/dylibbundler -cd -of -b -x ./Wargus.app/Contents/MacOS/stratagus -d ./Wargus.app/Contents/libs/
