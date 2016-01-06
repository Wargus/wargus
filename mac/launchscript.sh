#!/bin/bash

wd="$(pwd)"
appdir="$(cd "$(dirname "$0")" && pwd -P)"
cd "$appdir"
datadir="$HOME/.stratagus/wc2/data"
mkdir -p "$datadir"
versionfile="$datadir/extracted"
extractdata=false

if [ -f $versionfile ]; then
	HAS_VERSION="$(cat $versionfile >/dev/null)"
	NEW_VERSION="$(./wartool -V 2>/dev/null)"
	if [ ! "$HAS_VERSION" = "$NEW_VERSION" ]; then
	    answer=$(osascript -e 'display dialog "Warcraft II data is outdated, should we extract again? (If not, the game might still work. Or not.)" buttons {"Extract again", "No, just run"} default button 1')
	    if [[ $answer == *"Extract again"* ]]; then
		extractdata=true
	    fi
	fi
else
    osascript -e 'display dialog "Warcraft II data is not extracted, we need to do it now" buttons {"Ok"} default button 1'
    extractdata=true
fi

if [ extractdata ]; then
    dir=$(osascript -e "tell application \"SystemUIServer\" to return POSIX path of (choose folder with prompt \"Select location of Warcraft II data files\")")
    if [ $? -ne 0 ]; then
	osascript -e 'display dialog "No folder selected, exiting." buttons {"Exit"} default button 1'
	cd "$wd"
	exit 1
    fi

    echo $(pwd)
    cp -R ../Resources/campaigns \
          ../Resources/contrib \
          ../Resources/maps \
          ../Resources/scripts \
          "$datadir"/
    mkdir -p "$datadir"/graphics/ui
    cp ../Resources/contrib/* "$datadir"/graphics/ui/

    osascript -e "tell application \"Terminal\" to do script \"\
      cd $(pwd); clear; \
      ./wartool -v '$dir' '$datadir' || \
      ./wartool -v '$dir'/DATA '$datadir' || \
      ./wartool -v '$dir'/data '$datadir' \""

    osascript -e 'display dialog "Extracting data, please close the Terminal and press ok once done." buttons {"OK"} default button 1'
fi

exec ./stratagus -d "$datadir"
