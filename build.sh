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
##	(c) Copyright 1999-2002 by Lutz Sammer
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

# parameters
#
# -z / -I : COMPRESS = gzip --force --best / bzip2 --force
# -p path : ARCHIVE = /cdrom / /mnt/cdrom ..
# -o DIR = /usr/share/games/stratagus/warii
# -T path : BINPATH = /usr/lib/stratagus/tools
# -C CONTRIB = /usr/lib/stratagus/contrib
# -v : Extract also videos

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
#COMPRESS=$BZIP2

#
#       Here are the input files for sounds, graphics and texts.
#       WARNING: If not from CD, choose below expansion/no-expansion
#               First choice:   installed on dos parition
#               Second choise:  installed in current directory
#               Third choise:   uninstalled on original cdrom
#		or use -p dir
#
#ARCHIVE="/dos/c/games/war2/data/"
#ARCHIVE="./"
ARCHIVE=$CDROM"/data/"

#
#       Here are my executeables or -T dir.
#
BINPATH="."
#BINPATH="/usr/local/lib/stratagus/bin"
#BINPATH="/usr/lib/stratagus/tools"

#
#       Here are the extra files contributed or -C dir.
#
CONTRIB="contrib"
#CONTRIB="/usr/lib/stratagus/contrib"
#CONTRIB="/usr/local/lib/stratagus/contrib"

#
#       Here is the destination for the generated files
#
DIR="data"
#DIR="/usr/local/lib/stratagus/data"
#DIR="/usr/share/games/stratagus/WarII"

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

		-v)	VIDEO="-v"; shift ;;

		-h)	cat << EOF
build.sh
 -z / -I : COMPRESS = gzip --force --best / bzip2 --force
 -p path : ARCHIVE = /cdrom / /mnt/cdrom ..
 -o DIR = /usr/share/games/stratagus/warii
 -T path : BINPATH = /usr/lib/stratagus/tools
 -C CONTRIB = /usr/lib/stratagus/contrib
 -v : Also extract video
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

if [ ! -f "$DATADIR/rezdat.war" ] && [ ! -f "$DATADIR/War Resources" ]; then
    echo "error: '$DATADIR/rezdat.war' does not exist"
    echo "error: '$DATADIR/War Resources' does not exist"
    exit -1
fi

if [ ! -d "$CONTRIB" ]; then
    echo "error: $CONTRIB does not exist; try running $0" 
    echo "	from the toplevel stratagus directory."
    exit -1
fi

# Create the directory structure

[ -d $DIR ] || mkdir $DIR
[ -d $DIR/music ] || mkdir $DIR/music

# More is now done automatic

###############################################################################
##	Extract
###############################################################################

# copy script files
cp -R scripts $DIR/scripts

# ADD -e      To force that the archive is expansion compatible
# ADD -n      To force that the archive is not expansion compatible
$BINPATH/wartool $VIDEO "$DATADIR" "$DIR"

# copy own supplied files

cp $CONTRIB/cross.png $DIR/graphics/ui/cursors
cp $CONTRIB/red_cross.png $DIR/graphics/missiles
cp $CONTRIB/mana.png $DIR/graphics/ui
cp $CONTRIB/mana2.png $DIR/graphics/ui
cp $CONTRIB/health.png $DIR/graphics/ui
cp $CONTRIB/health2.png $DIR/graphics/ui
cp $CONTRIB/food.png $DIR/graphics/ui
cp $CONTRIB/score.png $DIR/graphics/ui
cp $CONTRIB/ore,stone,coal.png $DIR/graphics/ui
cp $CONTRIB/stratagus.png $DIR/graphics/ui
cp $CONTRIB/toccata.mod.gz $DIR/music/default.mod.gz

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
##	Copy original puds into data directory
#
echo "Copy puds and compressing"
[ -d $DATADIR/../puds ] && cp -r $DATADIR/../puds/ $DIR/
[ -f $DATADIR/../alamo.pud ] && cp -r $DATADIR/../*.pud $DIR/puds
chmod -R +w $DIR/puds
find $DIR/puds -type f -name "*.pud" -print -exec $COMPRESS {} \;

#
##	Copy contrib puds into data directory
#
[ -d $DIR/puds/single ] || mkdir $DIR/puds/single
[ -d $DIR/puds/multiple ] || mkdir $DIR/puds/multiple
cp $CONTRIB/puds/single/* $DIR/puds/single >/dev/null 2>&1
cp $CONTRIB/puds/multi/* $DIR/puds/multiple >/dev/null 2>&1

#
##	The default pud.
#
[ -f "$DIR/puds/multi/(2)mysterious-dragon-isle.pud.gz" ] \
	&& ln -s "multi/(2)mysterious-dragon-isle.pud.gz" \
	    $DIR/puds/default.pud.gz
[ -f "$DIR/puds/multi/(2)mysterious-dragon-isle.pud.bz2" ] \
	&& ln -s "multi/(2)mysterious-dragon-isle.pud.bz2" \
	    $DIR/puds/default.pud.bz2

#
##  Rename puds to maps for consistancy
mv $DIR/puds $DIR/maps
if [ -d $DIR/maps/my_puds ]; then
    mv $DIR/maps/my_puds $DIR/maps/my_maps
fi
	
exit 0
