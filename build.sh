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

#       cdrom autodetection
CDROM="/cdrom"
[ -d "/mnt/cdrom" ] && CDROM="/mnt/cdrom"

#       location of data files
ARCHIVE="$CDROM/data/"

#	output dir
DIR="data.wc2"

#       extra files to be copied.
CONTRIB="contrib"

#	location of the wartool binary
BINPATH="."

AUDIO_COMPRESS="oggenc"

####	Do not modify anything below this point.

SKIP_CONTRIB="no"
SKIP_SCRIPTS="no"

while [ $# -gt 0 ]; do
	case "$1" in
		-p)	ARCHIVE="$2"; shift ;;
		-o)	DIR="$2"; shift ;;

		-c)	SKIP_CONTRIB="yes";;
		-s)	SKIP_SCRIPTS="yes";;
		-v)	VIDEO="-v" ;;
		-m)	MUSIC="yes" ;;

		-h)	cat << EOF

build.sh [-v] [-o output] -p path 
 -v extract videos
 -m extract music
 -c skip contrib file copy
 -s skip scripts file copy
 -o output directory (default 'data.wc2')
 -p path to data files
EOF
			exit 1;;
		*)	$0 -h; exit 1;;
	esac
	shift
done

if [ -d "$ARCHIVE/data/" ]; then
	DATADIR="$ARCHIVE/data/"
else
	DATADIR="$ARCHIVE/"
fi

if [ ! -f "$DATADIR/rezdat.war" ] && [ ! -f "$DATADIR/REZDAT.WAR" ] && [ ! -f "$DATADIR/War Resources" ]; then
    echo "error: '$DATADIR/rezdat.war' does not exist"
    echo "error: '$DATADIR/War Resources' does not exist"
    echo "Specify the location of the data files with the '-p' option"
    exit 1
fi

if [ "$SKIP_CONTRIB" = "no" ] ; then
	if [ ! -d "$CONTRIB" ]; then
		echo "error: $CONTRIB does not exist; try running $0" 
		echo "	from the toplevel stratagus directory."
		exit 1
	fi
fi

# Create the directory structure

[ -d $DIR ] || mkdir $DIR
[ -d $DIR/music ] || mkdir $DIR/music
[ -d $DIR/puds ] || mkdir $DIR/puds

###############################################################################
##	Extract and Copy
###############################################################################

# copy script files
if [ "$SKIP_CONTRIB" = "no" ] ; then
	cp -R scripts $DIR/
	rm -Rf `find $DIR/scripts | grep CVS`
	rm -Rf `find $DIR/scripts | grep cvsignore`
	rm -Rf `find $DIR/scripts | grep .svn`
fi

##	Extract audio tracks
#
if [ "$MUSIC" = "yes" ] ; then
	seq -w 2 17 | (while read i ; do cdparanoia ${i} $DIR/music/track_${i}.wav ; \
		($AUDIO_COMPRESS $DIR/music/track_${i}.wav && rm $DIR/music/track_${i}.wav 2>/dev/null &) ; done)
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
else
	cp $CONTRIB/toccata.mod.gz $DIR/music/default.mod.gz
fi


$BINPATH/wartool $VIDEO "$DATADIR" "$DIR" || exit

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

if [ -e $DIR/graphics/ui/title.png ]; then
	mv $DIR/graphics/ui/title.png $DIR/graphics/ui/stratagus.png
elif [ "$SKIP_CONTRIB" = "no" ] ; then
	cp $CONTRIB/stratagus.png $DIR/graphics/ui
fi

#	Compress the sounds
find $DIR/sounds -type f -name "*.wav" -print -exec gzip -f {} \;

#	Compress the texts
find $DIR/campaigns -type f -name "*.txt" -print -exec gzip -f {} \;

#	Setup the default map
[ -f "$DIR/maps/multi/(2)mysterious-dragon-isle.sms.gz" ] && cd $DIR/maps \
	&& ln -sf "multi/(2)mysterious-dragon-isle.sms.gz" default.sms.gz \
	&& ln -sf "multi/(2)mysterious-dragon-isle.smp.gz" default.smp.gz

echo "Wargus data setup is now complete"
echo "Note: you do not need to run this script again"

exit 0
