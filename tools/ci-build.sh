#!/bin/bash
#
# Usage: tools/ci-build.sh linux|macos|windows

set -ex

GAME_ID=wargus
GAME_NAME=Wargus

if [ -z "${GAME_SRC}" ]; then
    GAME_SRC=$(cd "$(dirname "$0")" && cd .. && pwd)
fi
ENGINE_SRC=${ENGINE_SRC:-../stratagus}
ENGINE_BUILD=${ENGINE_BUILD:-$ENGINE_SRC/build}
BUILD=${GAME_BUILD:-$GAME_SRC/build}
ASSETS=${RELEASE_ASSETS:-release-assets}

ENGINE_SRC=$(cd "$ENGINE_SRC" && pwd)
ENGINE_BUILD=$(cd "$ENGINE_BUILD" && pwd)

for candidate in "$ENGINE_BUILD/stratagus" "$ENGINE_BUILD/Release/stratagus.exe" "$ENGINE_BUILD/stratagus.exe"; do
    if [ -e "$candidate" ]; then
        export STRATAGUS="$candidate"
        break
    fi
done
if [ ! -e "$STRATAGUS" ]; then
    echo "no stratagus build under $ENGINE_BUILD" >&2
    exit 1
fi

# Build
case "$1" in
    linux)
        cmake -S "$GAME_SRC" -B "$BUILD" \
              -DCMAKE_BUILD_TYPE=Release \
              -DENABLE_VENDORED_LIBS=ON \
              -DSTRATAGUS=stratagus \
              -DSTRATAGUS_INCLUDE_DIR="$ENGINE_SRC/gameheaders" \
              -DCMAKE_INSTALL_PREFIX=/usr \
              -DGAMEDIR=/usr/bin \
              -DGAMEDIRABS= \
              -DDATA_PATH="../../share/games/stratagus/$GAME_ID" \
              -DCMAKE_POLICY_VERSION_MINIMUM=3.5
        cmake --build "$BUILD" -j"$(nproc)" --config Release
        ;;
    macos)
        cmake -S "$GAME_SRC" -B "$BUILD" \
              -DCMAKE_BUILD_TYPE=Release \
              -DCMAKE_FIND_FRAMEWORK=LAST \
              -DSTRATAGUS="$STRATAGUS" \
              -DSTRATAGUS_INCLUDE_DIR="$ENGINE_SRC/gameheaders" \
              -DENABLE_VENDORED_LIBS=OFF \
              -DCMAKE_POLICY_VERSION_MINIMUM=3.5
        cmake --build "$BUILD" --config Release
        ;;
    windows)
        cmake -S "$GAME_SRC" -B "$BUILD" \
              -DCMAKE_BUILD_TYPE=Release \
              -DENABLE_NSIS=ON \
              -DSTRATAGUS="$STRATAGUS" \
              -DSTRATAGUS_INCLUDE_DIR="$ENGINE_SRC/gameheaders" \
              -DCMAKE_POLICY_VERSION_MINIMUM=3.5
        # n.b. the nsi ships the engine it finds next to it, and makensis runs
        # in the build directory, so the engine must be copied in before
        engine_dir=$(dirname "$STRATAGUS")
        cp "$engine_dir/stratagus.exe" "$engine_dir/stratagus-midiplayer.exe" "$BUILD/"

        cmake --build "$BUILD" --config Release
        ;;
    *)
        echo "usage: tools/ci-build.sh linux|macos|windows" >&2
        exit 1
        ;;
esac

# Bundle
case "$1" in
    linux)
        root=$(cd "$BUILD" && pwd)
        appdir=$root/AppDir
        version=$(head -1 "$GAME_SRC/debian/changelog" | sed -e 's/^[^(]*(//' -e 's/).*//' -e 's/-[^-]*$//')
        DESTDIR="$appdir" cmake --install "$ENGINE_BUILD"
        DESTDIR="$appdir" cmake --install "$BUILD"

        cat > "$root/appimage-builder.yaml" <<EOF
version: 1
AppDir:
  path: $appdir
  app_info:
    id: com.stratagus.$GAME_ID
    name: '$GAME_NAME'
    icon: '$GAME_ID'
    version: '$version'
    exec: 'usr/bin/$GAME_ID'
    exec_args: '"--argv0=\$APPDIR/usr/bin/$GAME_ID" \$@'
AppImage:
  arch: '$(uname -m)'
EOF

        builder=$root/tools/appimage-builder.AppImage
        if [ ! -x "$builder" ]; then
            mkdir -p "$(dirname "$builder")"
            curl -L --output "$builder" https://github.com/AppImageCrafters/appimage-builder/releases/download/v1.1.0/appimage-builder-1.1.0-x86_64.AppImage
            chmod +x "$builder"
        fi
        mkdir -p "$ASSETS"
        pushd "$root"
        $builder --appimage-extract-and-run --recipe appimage-builder.yaml
        popd
        cp -v "$root"/*.AppImage "$ASSETS"/
        ;;
    macos)
        "$GAME_SRC/mac/bundle.sh"
        app=$GAME_SRC/mac/Wargus.app
        for binary in stratagus wartool; do
            dylibbundler -of -cd -b -x "$app/Contents/MacOS/$binary" -d "$app/Contents/libs/"
        done
        codesign --force --deep --sign - "$app"

        version=$(/usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' "$GAME_SRC/mac/Info.plist")
        arch=$(uname -m)
        mkdir -p "$ASSETS"
        output="$ASSETS/Wargus-$version-$arch"
        for attempt in 1 2 3; do # mounting fails sporadically, retry a few times
            hdiutil detach /Volumes/Wargus -force || true
            if hdiutil create -volname Wargus -srcfolder "$app" "$output"; then
                exit 0
            fi
            rm -f "$output" "$output.dmg"
            sleep $((attempt * 10))
        done
        hdiutil create -volname Wargus -srcfolder "$app" "$output"
        ;;
    windows)
        mkdir -p "$ASSETS"
        cp "$BUILD"/Wargus-*.exe "$ASSETS"/
        ;;
esac
