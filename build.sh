#!/bin/sh
##   ___________		     _________		      _____  __
##   \_	  _____/______   ____   ____ \_   ___ \____________ _/ ____\/  |_
##    |    __) \_  __ \_/ __ \_/ __ \/    \  \/\_  __ \__  \\   __\\   __\ 
##    |     \   |  | \/\  ___/\  ___/\     \____|  | \// __ \|  |   |  |
##    \___  /   |__|    \___  >\___  >\______  /|__|  (____  /__|   |__|
##	  \/		    \/	   \/	     \/		   \/
##  ______________________                           ______________________
##			  T H E   W A R   B E G I N S
##	   FreeCraft - A free fantasy real time strategy game engine
##
##	build.sh	-	The graphics and sound extractor.
##
##	(c) Copyright 1999-2001 by Lutz Sammer
##
##	FreeCraft is free software; you can redistribute it and/or modify
##	it under the terms of the GNU General Public License as published
##	by the Free Software Foundation; either version 2 of the License,
##	or (at your option) any later version.
##
##	FreeCraft is distributed in the hope that it will be useful,
##	but WITHOUT ANY WARRANTY; without even the implied warranty of
##	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##	GNU General Public License for more details.
##
##	$Id$
##

# parameters
#
# -z / -I : COMPRESS = gzip --force --best / bzip2 --force
# -p path : ARCHIVE = /cdrom / /mnt/cdrom ..
# -o DIR = /usr/share/games/freecraft/warii
# -T path : BINPATH = /usr/lib/freecraft/tools
# -C CONTRIB = /usr/lib/freecraft/contrib

#	compress parameters
GZIP="gzip --force --best"
BZIP2="bzip2 --force"

#       cdrom autodetection
CDROM="/cdrom"
[ -d "/mnt/cdrom" ] && CDROM="/mnt/cdrom"

###
### Change the next, to meet your requirements:
###

#
#       Choose your default compression or use -z or -I.
#
COMPRESS=$GZIP
COMPRESS=$BZIP2

#
#       Here are the input files for sounds, graphics and texts.
#       WARNING: If not from CD, choose below expansion/no-expansion
#               First choice:   installed on dos parition
#               Second choise:  installed in current directory
#               Third choise:   uninstalled on original cdrom
#		or use -p dir
#
ARCHIVE="/misc/win98/freecraft/war2/data/"
#ARCHIVE="./"
#ARCHIVE=$CDROM"/data/"

#
#       Here are my executeables or -T dir.
#
BINPATH="tools"
#BINPATH="/usr/local/lib/freecraft/bin"
#BINPATH="/usr/lib/freecraft/tools"

#
#       Here are the extra files contributed or -C dir.
#
CONTRIB="contrib"
#CONTRIB="/usr/lib/freecraft/contrib"
#CONTRIB="/usr/local/lib/freecraft/contrib"

#
#       Here is the destination for the generated files
#
DIR="data"
#DIR="/usr/local/lib/freecraft/data"
#DIR="/usr/share/games/freecraft/WarII"

###
###	Below this point, you should only search bugs. :-)
###

while [ $# -gt 0 ]; do
	case "$1" in
		-p)	ARCHIVE="$2"; shift ;;
		-o)	DIR="$2"; shift ;;

		-z)	COMPRESS="$GZIP" ;;
		-I)	COMPRESS="$BZIP2" ;;

		-T)	BINPATH="$2"; shift ;;
		-C)	CONTRIB="$2"; shift ;;

		-h)	cat << EOF
build.sh
 -z / -I : COMPRESS = gzip --force --best / bzip2 --force
 -p path : ARCHIVE = /cdrom / /mnt/cdrom ..
 -o DIR = /usr/share/games/freecraft/warii
 -T path : BINPATH = /usr/lib/freecraft/tools
 -C CONTRIB = /usr/lib/freecraft/contrib
EOF
			exit 0;;

		*)
			echo 2>&1 "Unknown option: $1"
			exit 1
	esac
	shift
done

if [ -d "$ARCHIVE/data/" ]; then
	DATADIR="$ARCHIVE/data/"
else
	DATADIR="$ARCHIVE/"
fi

# Create the directory structure

[ -d $DIR ] || mkdir $DIR
[ -d $DIR/music ] || mkdir $DIR/music

# More is now done automatic

###############################################################################
##	Extract
###############################################################################

# ADD -e      To force that the archive is expansion compatible
# ADD -n      To force that the archive is not expansion compatible
$BINPATH/wartool "$DATADIR" "$DIR"

# copy own supplied files

cp $CONTRIB/cross.png $DIR/graphics/ui/cursors
cp $CONTRIB/mana.png $DIR/graphics/ui
cp $CONTRIB/mana2.png $DIR/graphics/ui
cp $CONTRIB/health.png $DIR/graphics/ui
cp $CONTRIB/health2.png $DIR/graphics/ui
cp $CONTRIB/food.png $DIR/graphics/ui
cp $CONTRIB/score.png $DIR/graphics/ui
cp $CONTRIB/ore,stone,coal.png $DIR/graphics/ui
cp $CONTRIB/freecraft.png $DIR/graphics/ui
cp $CONTRIB/music/toccata.mod.gz $DIR/music/default.mod.gz

###############################################################################
##	MISC
###############################################################################

#
#	Compress the sounds
#
find $DIR/sounds -type f -name "*.wav" -print -exec $COMPRESS {} \;

#
#	Compress the texts
#
find $DIR/campaigns -type f -name "*.txt" -print -exec $COMPRESS {} \;

#
#	Copy original puds into data directory
#
echo "Copy puds and compressing"
[ -d $DATADIR/../puds ] && cp -r $DATADIR/../puds/ $DIR/
[ -f $DATADIR/../alamo.pud ] && cp -r $DATADIR/../*.pud $DIR/puds
chmod -R +w $DIR/puds
find $DIR/puds -type f -name "*.pud" -print -exec $COMPRESS {} \;

#
##	The default pud.
#
[ -f $DIR/puds/internal/internal12.pud.gz ] \
	&& ln -s puds/internal/internal12.pud.gz $DIR/default.pud.gz
[ -f $DIR/puds/internal/internal12.pud.bz2 ] \
	&& ln -s puds/internal/internal12.pud.bz2 $DIR/default.pud.bz2

exit 0
