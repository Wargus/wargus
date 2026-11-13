#!/bin/bash
#
# Build a Linux AppImage of Wargus, the artifact we ship for Linux releases.
#
# The engine and the game are built against the vendored dependencies of their
# third-party/ directories and installed into an AppDir, which is then bundled
# with appimage-builder. Nothing is expected to be installed on the target
# system, and the build host only needs the headers the vendored SDL2 build
# picks up by itself.
#
# Usage:  tools/build_appimage.sh [/path/to/stratagus]
#
# The engine source tree defaults to ../stratagus, which is what the appimage
# job in .github/workflows/ubuntu.yml checks out next to this repository. Both
# builds happen in build-appimage/ so that a development build directory is
# left alone, and the finished AppImage is written to the current directory.
#
# Environment overrides: GAME_VERSION (otherwise read from debian/changelog),
# APPIMAGE_BUILDER (path to an appimage-builder to use instead of downloading
# one), and CMAKE_BUILD_TYPE.

set -ex

GAME_ID=wargus
GAME_NAME=Wargus

STRATAGUS_SRC=${1:-../stratagus}
STRATAGUS_SRC=$(cd "$STRATAGUS_SRC" && pwd)
GAME_SRC=$(cd "$(dirname "$0")/.." && pwd)
BUILD_DIR=$(pwd)/build-appimage
APPDIR=$BUILD_DIR/AppDir
BUILD_TYPE=${CMAKE_BUILD_TYPE:-Release}
JOBS=$(nproc)

if [ -z "$GAME_VERSION" ]; then
    # the version of the topmost entry in the changelog, without the revision
    GAME_VERSION=$(head -1 "$GAME_SRC/debian/changelog" | sed -e 's/^[^(]*(//' -e 's/).*//' -e 's/-[^-]*$//')
fi

# The engine goes into the AppDir with the prefix the AppImage runtime expects,
# and its binary into usr/bin, where the AppRun also puts it on PATH so that
# the launcher finds it.
cmake -S "$STRATAGUS_SRC" -B "$BUILD_DIR/stratagus" \
    -DCMAKE_BUILD_TYPE="$BUILD_TYPE" \
    -DBUILD_VENDORED_LUA=ON \
    -DBUILD_VENDORED_SDL=ON \
    -DBUILD_VENDORED_MEDIA_LIBS=ON \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DGAMEDIR=/usr/bin \
    -DCMAKE_POLICY_VERSION_MINIMUM=3.5
cmake --build "$BUILD_DIR/stratagus" -j "$JOBS"
DESTDIR="$APPDIR" cmake --install "$BUILD_DIR/stratagus"

# The game is built against the engine installed above. STRATAGUS is a bare
# name, so the launcher looks it up on PATH and falls back to its own
# directory, and DATA_PATH is relative to the launcher for the same reason:
# from usr/bin/wargus it resolves to usr/share/games/stratagus/wargus inside
# the AppDir.
cmake -S "$GAME_SRC" -B "$BUILD_DIR/game" \
    -DCMAKE_BUILD_TYPE="$BUILD_TYPE" \
    -DENABLE_VENDORED_LIBS=ON \
    -DSTRATAGUS=stratagus \
    -DSTRATAGUS_INCLUDE_DIR="$STRATAGUS_SRC/gameheaders" \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DGAMEDIR=/usr/bin \
    -DGAMEDIRABS= \
    -DDATA_PATH="../../share/games/stratagus/$GAME_ID" \
    -DCMAKE_POLICY_VERSION_MINIMUM=3.5
cmake --build "$BUILD_DIR/game" -j "$JOBS"
DESTDIR="$APPDIR" cmake --install "$BUILD_DIR/game"

cat > "$BUILD_DIR/appimage-builder.yaml" <<EOF
version: 1
AppDir:
  path: $APPDIR
  app_info:
    id: com.stratagus.$GAME_ID
    name: '$GAME_NAME'
    icon: '$GAME_ID'
    version: '$GAME_VERSION'
    exec: 'usr/bin/$GAME_ID'
    exec_args: '"--argv0=\$APPDIR/usr/bin/$GAME_ID" \$@'
AppImage:
  arch: '$(uname -m)'
EOF

# --argv0 tells the launcher where it lives, because inside an AppImage it is
# invoked as usr/bin/wargus from the AppRun rather than from where it is
# installed, and it resolves its data path relative to that.

if [ -z "$APPIMAGE_BUILDER" ]; then
    # not under $BUILD_DIR, which is searched for the finished AppImages
    APPIMAGE_BUILDER_APPIMAGE=$BUILD_DIR/tools/appimage-builder.AppImage
    if [ ! -x "$APPIMAGE_BUILDER_APPIMAGE" ]; then
        mkdir -p "$(dirname "$APPIMAGE_BUILDER_APPIMAGE")"
        curl -L --output "$APPIMAGE_BUILDER_APPIMAGE" \
            https://github.com/AppImageCrafters/appimage-builder/releases/download/v1.1.0/appimage-builder-1.1.0-x86_64.AppImage
        chmod +x "$APPIMAGE_BUILDER_APPIMAGE"
    fi
    APPIMAGE_BUILDER="$APPIMAGE_BUILDER_APPIMAGE --appimage-extract-and-run"
fi

(
    cd "$BUILD_DIR"
    $APPIMAGE_BUILDER --recipe appimage-builder.yaml
)

cp -v "$BUILD_DIR"/*.AppImage .
