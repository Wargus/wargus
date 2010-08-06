#!/bin/sh
##       _________ __                 __                               
##      /   _____//  |_____________ _/  |______     ____  __ __  ______
##      \_____  \\   __\_  __ \__  \\   __\__  \   / ___\|  |  \/  ___/
##      /        \|  |  |  | \// __ \|  |  / __ \_/ /_/  >  |  /\___ \ 
##     /_______  /|__|  |__|  (____  /__| (____  /\___  /|____//____  >
##             \/                  \/          \//_____/            \/ 
##  ______________________                           ______________________
##			  T H E   W A R   B E G I N S
##	   Stratagus - A free fantasy real time strategy game engine
##
##	build.sh	-	The graphics and sound extractor.
##
##	(c) Copyright 1999-2005 by The Stratagus Team
##	(c) Copyright 2010      by Pali Rohár
##
##	Stratagus is free software; you can redistribute it and/or modify
##	it under the terms of the GNU General Public License as published
##	by the Free Software Foundation; only version 2 of the License.
##
##	Stratagus is distributed in the hope that it will be useful,
##	but WITHOUT ANY WARRANTY; without even the implied warranty of
##	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##	GNU General Public License for more details.
##
##	$Id$
##

set -e

export PATH=/usr/bin/gnu:$PATH

# cdrom autodetection
CDROM="/cdrom"
[ -d "/mnt/cdrom" ] && CDROM="/mnt/cdrom"
[ -d "/media/cdrom" ] && CDROM="/mnt/cdrom"

# location of data files
ARCHIVE="$CDROM"

# output dir
DIR="data.wc2"

# extra files to be copied.
CONTRIB="contrib"

# location of the wartool binary
BINPATH="."

# convert programs
DECODE="ffmpeg2theora"
DECODE_ARGS="--optimize"
CDPARANOIA="cdparanoia"
TIMIDITY="timidity"

#### Do not modify anything below this point.

SKIP_CONTRIB="no"
SKIP_SCRIPTS="no"

while [ $# -gt 0 ]; do
	case "$1" in
		-p)	ARCHIVE="$2"; shift ;;
		-o)	DIR="$2"; shift ;;

		-c)	SKIP_CONTRIB="yes";;
		-s)	SKIP_SCRIPTS="yes";;
		-v)	VIDEO="-v" ;;
		-b)	BINPATH="$2"; shift;;
		-m)	MUSIC="yes" ;;
		-d)	DRIVE="-d $2"; shift;;

		-h)	cat << EOF

build.sh [-v] [-m] [-b binpath] [-d cddrive] [-c] [-s] [-o output] -p path 
 -v extract videos (default: no)
 -m extract music (default: no)
 -b binpath of wartool (default: .)
 -d cddrive for audio tracks (default: check /dev/cdrom /dev/scd0)
 -c skip contrib file copy (default: no)
 -s skip scripts file copy (default: no)
 -o output directory (default: 'data.wc2')
 -p path to data files (default: check /media/cdrom /mnt/cdrom /cdrom)
EOF
			exit 1;;
		*)	$0 -h; exit 1;;
	esac
	shift
done

if [ -d "$ARCHIVE/data/" ]; then
	DATADIR="$ARCHIVE/data"
elif [ -d "$ARCHIVE/DATA/" ]; then
	DATADIR="$ARCHIVE/DATA"
else
	DATADIR="$ARCHIVE"
fi

if [ ! -f "$DATADIR/rezdat.war" ] && [ ! -f "$DATADIR/REZDAT.WAR" ] && [ ! -f "$DATADIR/War Resources" ]; then
	echo "Error: '$DATADIR/rezdat.war' does not exist"
	echo "Error: '$DATADIR/REZDAT.WAR' does not exist"
	echo "Error: '$DATADIR/War Resources' does not exist"
	echo "Specify the location of the data files with the '-p' option"
	exit 1
fi

if [ "$SKIP_CONTRIB" = "no" ] ; then
	if [ ! -d "$CONTRIB" ]; then
		echo "Error: $CONTRIB does not exist; try running $0" 
		echo "	from the toplevel stratagus directory."
		exit 1
	fi
fi

# create the directory structure
[ -d $DIR ] || mkdir $DIR
[ -d $DIR/music ] || mkdir $DIR/music
[ -d $DIR/maps ] || mkdir $DIR/maps

# check if audio tracks are not allready extracted
if [ "$MUSIC" = "yes" ]; then
	if [ -e "$DATADIR/music" ]; then
		echo "Note: found extracted audio tracks in $DATADIR/music, only copy them"
		cp $DATADIR/music/* $DIR/music/
		MUSIC="no"
	fi
fi

# check if $CDPARANOIA is installed
if ! which "$CDPARANOIA" >/dev/null; then
	if [ "$MUSIC" = "yes" ]; then
		echo "Warning: $CDPARANOIA is not installed in system"
		echo "$CDPARANOIA is needed for extract music"
	fi
	MUSIC="no"
fi

# check if $DECODE is installed
if ! which "$DECODE" >/dev/null; then
	if [ "$MUSIC" = "yes" ] || [ "$VIDEO" != "" ]; then
		echo "Warning: $DECODE is not installed in system"
		echo "$DECODE is needed for extract music and videos"
	fi
	MUSIC="no"
	VIDEO=""
	MIDI="no"
fi

# check if $TIMIDITY is installed
if ! which "$TIMIDITY" >/dev/null; then
	MIDI="no"
fi

###############################################################################
##	Extract and Copy
###############################################################################

# copy script files
if [ "$SKIP_SCRIPTS" = "no" ] ; then
	cp -R scripts $DIR/
	rm -Rf `find $DIR/scripts | grep CVS`
	rm -Rf `find $DIR/scripts | grep cvsignore`
	rm -Rf `find $DIR/scripts | grep .svn`
fi

# check if cdparanoia can extract audio tracks from CD
if [ "$MUSIC" = "yes" ] ; then
	if [ "$DRIVE" != "" ] ; then
       		if ! $CDPARANOIA $DRIVE -Q 1>/dev/null 2>&1 ; then
			MUSICCD="no"
			MUSIC="no"
		fi
	elif ! $CDPARANOIA -Q 1>/dev/null 2>&1 ; then
		## cdparanoia doesnt check /dev/scd0
		if $CDPARANOIA -d /dev/scd0 -Q 1>/dev/null 2>&1 ; then
			DRIVE="-d /dev/scd0"
		else
			MUSICCD="no"
			MUSIC="no"
		fi
	fi
fi

# extract audio tracks
if [ "$MUSIC" = "yes" ] ; then
	seq -w 2 18 | (while read i ; do $CDPARANOIA $DRIVE ${i} $DIR/music/track_${i}.wav ; \
		($DECODE $DECODE_ARGS $DIR/music/track_${i}.wav -o $DIR/music/track_${i}.ogg && rm -f $DIR/music/track_${i}.wav 2>/dev/null &) ; done)
	mv $DIR/music/track_02.ogg "$DIR/music/Human Battle 1.ogg"
	mv $DIR/music/track_03.ogg "$DIR/music/Human Battle 2.ogg"
	mv $DIR/music/track_04.ogg "$DIR/music/Human Battle 3.ogg"
	mv $DIR/music/track_05.ogg "$DIR/music/Human Battle 4.ogg"
	mv $DIR/music/track_06.ogg "$DIR/music/Human Battle 5.ogg"
	mv $DIR/music/track_07.ogg "$DIR/music/Human Briefing.ogg"
	mv $DIR/music/track_08.ogg "$DIR/music/Human Victory.ogg"
	mv $DIR/music/track_09.ogg "$DIR/music/Human Defeat.ogg"
	mv $DIR/music/track_10.ogg "$DIR/music/Orc Battle 1.ogg"
	mv $DIR/music/track_11.ogg "$DIR/music/Orc Battle 2.ogg"
	mv $DIR/music/track_12.ogg "$DIR/music/Orc Battle 3.ogg"
	mv $DIR/music/track_13.ogg "$DIR/music/Orc Battle 4.ogg"
	mv $DIR/music/track_14.ogg "$DIR/music/Orc Battle 5.ogg"
	mv $DIR/music/track_15.ogg "$DIR/music/Orc Briefing.ogg"
	mv $DIR/music/track_16.ogg "$DIR/music/Orc Victory.ogg"
	mv $DIR/music/track_17.ogg "$DIR/music/Orc Defeat.ogg"
	mv $DIR/music/track_18.ogg "$DIR/music/I'm a Medieval Man.ogg"
else
	if [ "$MUSICCD" = "no" ]; then
		echo "Warning: Audio CD device not found"
		echo "If you want to extract music, specify CD drive location with the '-d' param"
	fi
	if [ "$SKIP_CONTRIB" = "no" ] && [ ! -f "$DIR/music/Orc Briefing.ogg" ]; then
		echo "Using default music file"
		cp $CONTRIB/toccata.mod.gz "$DIR/music/Orc Briefing.ogg.gz"
	fi
fi

# copy campaigns scripts
if [ "$SKIP_CONTRIB" = "no" ]; then
	if [ ! -e "$CONTRIB/../campaigns" ]; then
		echo "Error: Campaigns scripts not found in $CONTRIB/../campaigns"
		exit 1
	fi
	cp -r "$CONTRIB/../campaigns" "$DIR"
fi

# extract data using wartool
$BINPATH/wartool $VIDEO "$DATADIR" "$DIR" || exit

# convert video files to theora format
if [ "$VIDEO" != "" ]; then
	for f in $DIR/videos/*.smk ; do
		$DECODE $DECODE_ARGS $f -o ${f%%.smk}.ogv
		rm -f $f
	done
fi

# convert midi to ogg
if [ "$MIDI" != "no" ]; then
	for f in $DIR/music/*.mid.gz ; do
		$TIMIDITY -Ow $f -o - | $DECODE $DECODE_ARGS - -o - | gzip > ${f%%.mid.gz}.ogg.gz
		rm -f $f
	done
fi

# copy own supplied files
if [ "$SKIP_CONTRIB" = "no" ] ; then
	cp $CONTRIB/cross.png $DIR/graphics/ui/cursors
	cp $CONTRIB/red_cross.png $DIR/graphics/missiles
	cp $CONTRIB/mana.png $DIR/graphics/ui
	cp $CONTRIB/mana2.png $DIR/graphics/ui
	cp $CONTRIB/health.png $DIR/graphics/ui
	cp $CONTRIB/health2.png $DIR/graphics/ui
	cp $CONTRIB/food.png $DIR/graphics/ui
	cp $CONTRIB/score.png $DIR/graphics/ui
	cp $CONTRIB/ore,stone,coal.png $DIR/graphics/ui
fi

# compress the sounds
find $DIR/sounds -type f -name "*.wav" -print -exec gzip -f {} \; || true

# compress the texts
find $DIR/campaigns -type f -name "*.txt" -print -exec gzip -f {} \; || true

echo "Wargus data setup is now complete"
echo "Note: you do not need to run this script again"

exit 0
