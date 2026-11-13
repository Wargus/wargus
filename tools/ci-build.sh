#!/bin/bash
#
# The Wargus half of the continuous integration.
#
# The build that runs this lives with the engine it builds, in
# Wargus/stratagus/.github/workflows/game-build.yml, because there is nothing
# Wargus-specific about checking out the two repositories, building the engine
# and publishing what comes out. What is left for here is the game's own build and
# the package of the platform it is being run for: the Windows installer, the
# macOS dmg and the Linux AppImage. Those differ between the games in the
# arguments of the game's cmake invocation, in the extractor tool that has to
# travel with the game, in which libraries have to be put inside the bundle, and
# in what the installer is built from.
#
# Usage: tools/ci-build.sh linux|macos|windows
#
# The game and the engine are checked out side by side, and this is started from
# that directory, which says where everything is:
#
#   GAME_SRC      the game checkout, this script's own repository
#   ENGINE_SRC    the engine checkout, whose gameheaders the launcher is built with
#   ENGINE_BUILD  where the engine was built, see find_engine for the layout
#   RELEASE_ASSETS
#                 where the artifact that gets published goes
#   APPIMAGE_BUILDER
#                 an appimage-builder to use instead of downloading one
#
# The game is built in $GAME_BUILD, or build/ next to the checkout, and the
# AppImage of Linux in the one next to it.

set -ex

GAME_ID=wargus
GAME_NAME=Wargus

GAME_SRC=${GAME_SRC:-.}
ENGINE_SRC=${ENGINE_SRC:-../stratagus}
ENGINE_BUILD=${ENGINE_BUILD:-$ENGINE_SRC/build}
BUILD=${GAME_BUILD:-$GAME_SRC/build}
ASSETS=${RELEASE_ASSETS:-release-assets}

# cmake wants to be told where the engine is, and a path relative to this
# script's directory is not what it understands, so the engine is looked up
# absolutely before it is named in any of the arguments below.
ENGINE_SRC=$(cd "$ENGINE_SRC" && pwd)
ENGINE_BUILD=$(cd "$ENGINE_BUILD" && pwd)

# The engine is built without a configuration directory except on Windows, where
# the multi-config generators put the binaries of each configuration in one.
find_engine() {
    for candidate in "$ENGINE_BUILD/stratagus$1" "$ENGINE_BUILD/Release/stratagus$1"; do
        if [ -e "$candidate" ]; then
            echo "$candidate"
            return
        fi
    done
    echo "no stratagus$1 built under $ENGINE_BUILD" >&2
    exit 1
}

case "$1" in
linux)
    # The Linux artifact is an AppImage: the engine and the game installed into one
    # directory with the prefix the AppImage runtime expects, and bundled with
    # appimage-builder. Nothing needs to be installed on the machine the result runs
    # on, and the game takes its libraries from third-party, so a build host only
    # needs the headers that those pick up by itself. Everything about it is under one
    # directory, absolutely named, because the bundler is run from inside it and finds
    # nothing on a relative path there.
    mkdir -p "$BUILD-appimage"
    root=$(cd "$BUILD-appimage" && pwd)
    appdir=$root/AppDir

    version=$(head -1 "$GAME_SRC/debian/changelog" | sed -e 's/^[^(]*(//' -e 's/).*//' -e 's/-[^-]*$//')

    # The engine is the one the workflow built, and it is configured with this prefix
    # so that its binary lands in usr/bin, where the AppRun puts it on PATH and where
    # the launcher looks for it.
    DESTDIR="$appdir" cmake --install "$ENGINE_BUILD"

    # The game is built against that engine. STRATAGUS is a bare name, so the launcher
    # looks it up on PATH and falls back to its own directory, and DATA_PATH is
    # relative to the launcher for the same reason: from usr/bin/wargus it resolves to
    # usr/share/games/stratagus/wargus inside the AppDir.
    cmake -S "$GAME_SRC" -B "$root/game" \
        -DCMAKE_BUILD_TYPE=Release \
        -DENABLE_VENDORED_LIBS=ON \
        -DSTRATAGUS=stratagus \
        -DSTRATAGUS_INCLUDE_DIR="$ENGINE_SRC/gameheaders" \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DGAMEDIR=/usr/bin \
        -DGAMEDIRABS= \
        -DDATA_PATH="../../share/games/stratagus/$GAME_ID" \
        -DCMAKE_POLICY_VERSION_MINIMUM=3.5
    cmake --build "$root/game" -j"$(nproc)" --config Release
    DESTDIR="$appdir" cmake --install "$root/game"

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

    # --argv0 tells the launcher where it lives, because inside an AppImage it is
    # invoked as usr/bin/wargus from the AppRun rather than from where it is installed,
    # and it resolves its data path relative to that.

    if [ -z "$APPIMAGE_BUILDER" ]; then
        # not under $root, which is searched for the finished AppImages
        builder=$root-tools/appimage-builder.AppImage
        if [ ! -x "$builder" ]; then
            mkdir -p "$(dirname "$builder")"
            curl -L --output "$builder" \
                https://github.com/AppImageCrafters/appimage-builder/releases/download/v1.1.0/appimage-builder-1.1.0-x86_64.AppImage
            chmod +x "$builder"
        fi
        APPIMAGE_BUILDER="$builder --appimage-extract-and-run"
    fi

    mkdir -p "$ASSETS"
    (
        cd "$root"
        # The name of the artifact comes from the recipe, so it says which version of
        # the game it is, and the master-builds release only ever holds the current
        # development build.
        $APPIMAGE_BUILDER --recipe appimage-builder.yaml
    )
    cp -v "$root"/*.AppImage "$ASSETS"/
    ;;

macos)
    cmake -S "$GAME_SRC" -B "$BUILD" \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_FIND_FRAMEWORK=LAST \
        -DSTRATAGUS="$(find_engine)" \
        -DSTRATAGUS_INCLUDE_DIR="$ENGINE_SRC/gameheaders" \
        -DENABLE_VENDORED_LIBS=OFF \
        -DCMAKE_POLICY_VERSION_MINIMUM=3.5
    cmake --build "$BUILD" --config Release

    # bundle.sh assembles the app bundle from the build directories next to it,
    # and only wants to know where the engine it ships is.
    export STRATAGUS="$(find_engine)"
    "$GAME_SRC/mac/bundle.sh"

    app=$GAME_SRC/mac/Wargus.app
    # The libraries come from Homebrew and nothing else travels with the game, so
    # they are copied into the bundle and their install names fixed up.
    for binary in stratagus wartool; do
        dylibbundler -of -cd -b -x "$app/Contents/MacOS/$binary" \
            -d "$app/Contents/libs/"
    done
    codesign --force --deep --sign - "$app"

    # The dmg is named after the game version in the bundle, so that the asset of
    # a release says which version it is and the master-builds release only ever
    # holds the current development build. Mounting the image is what fails now
    # and then, hence the retries.
    version=$(/usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' "$GAME_SRC/mac/Info.plist")
    arch=$(uname -m)
    mkdir -p "$ASSETS"
    output="$ASSETS/Wargus-$version-$arch"
    for attempt in 1 2 3; do
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
    cmake -S "$GAME_SRC" -B "$BUILD" \
        -DCMAKE_BUILD_TYPE=Release \
        -DENABLE_NSIS=ON \
        -DSTRATAGUS="$(find_engine .exe)" \
        -DSTRATAGUS_INCLUDE_DIR="$ENGINE_SRC/gameheaders" \
        -DCMAKE_POLICY_VERSION_MINIMUM=3.5
    # wargus.nsi ships the engine it finds next to it, and makensis runs in the
    # build directory, so the engine is copied in before the installer is made.
    engine_dir=$(dirname "$(find_engine .exe)")
    cp "$engine_dir/stratagus.exe" "$engine_dir/stratagus-midiplayer.exe" "$BUILD/"
    cmake --build "$BUILD" --config Release

    mkdir -p "$ASSETS"
    cp "$BUILD"/Wargus-*.exe "$ASSETS"/
    ;;

*)
    echo "usage: tools/ci-build.sh linux|macos|windows" >&2
    exit 1
    ;;
esac
