#!/bin/sh
##
##	A clone of a famous game.
##
##	build.sh	-	The graphics and sound extractor.
##
##	(c) Copyright 1999-2000 by Lutz Sammer
##
##	$Id$
##

# parameters
#
# -z / -I : COMPRESS = gzip --force --best / bzip2 --force
# -p path : ARCHIVE = /cdrom / /mnt/cdrom ..
# -o DIR = /usr/share/games/ale-clone/warii
# -T path : BINPATH = /usr/lib/ale-clone/tools
# -C CONTRIB = /usr/lib/ale-clone/contrib

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
BINPATH="tools"
#BINPATH="/usr/local/lib/clone/bin"
#BINPATH="/usr/lib/ale-clone/tools"

#
#       Here are the extra files contributed or -C dir.
#
CONTRIB="contrib"
#CONTRIB="/usr/lib/ale-clone/contrib"
#CONTRIB="/usr/local/lib/clone/contrib"

#
#       Here is the destination for the generated files
#
DIR="data"
#DIR="/usr/local/lib/clone/data"
#DIR="/usr/share/games/ale-clone/WarII"

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
 -o DIR = /usr/share/games/ale-clone/warii
 -T path : BINPATH = /usr/lib/ale-clone/tools
 -C CONTRIB = /usr/lib/ale-clone/contrib
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

[ -d $DIR/graphic ] || mkdir $DIR/graphic
[ -d $DIR/graphic/tileset ] || mkdir $DIR/graphic/tileset
[ -d $DIR/graphic/interface ] || mkdir $DIR/graphic/interface

[ -d $DIR/sound ] || mkdir $DIR/sound

[ -d $DIR/campaigns ] || mkdir $DIR/campaigns
[ -d $DIR/campaigns/human ] || mkdir $DIR/campaigns/human
[ -d $DIR/campaigns/orc ] || mkdir $DIR/campaigns/orc
[ -d $DIR/campaigns/human-exp ] || mkdir $DIR/campaigns/human-exp
[ -d $DIR/campaigns/orc-exp ] || mkdir $DIR/campaigns/orc-exp
[ -d $DIR/text ] || mkdir $DIR/text

[ -d $DIR/puds ] || mkdir $DIR/puds
[ -d $DIR/puds/internal ] || mkdir $DIR/puds/internal
[ -d $DIR/puds/demo ] || mkdir $DIR/puds/demo

# New directory structure
[ -d $DIR/graphic/tilesets ] || mkdir $DIR/graphic/tilesets
[ -d $DIR/graphic/tilesets/summer ] || mkdir $DIR/graphic/tilesets/summer
[ -d $DIR/graphic/tilesets/winter ] || mkdir $DIR/graphic/tilesets/winter
[ -d $DIR/graphic/tilesets/wasteland ] || mkdir $DIR/graphic/tilesets/wasteland
[ -d $DIR/graphic/tilesets/swamp ] || mkdir $DIR/graphic/tilesets/swamp
[ -d $DIR/graphic/ui ] || mkdir $DIR/graphic/ui
[ -d $DIR/graphic/ui/human ] || mkdir $DIR/graphic/ui/human
[ -d $DIR/graphic/ui/orc ] || mkdir $DIR/graphic/ui/orc

###############################################################################
##	Extract
###############################################################################

# ADD -e      To force that the archive is expansion compatible
# ADD -n      To force that the archive is not expansion compatible
$BINPATH/wartool "$DATADIR" "$DIR"

# own supplied files

cp $CONTRIB/cross.png $DIR/graphic
cp $CONTRIB/mana.png $DIR
cp $CONTRIB/health.png $DIR
cp $CONTRIB/food.png $DIR/graphic
cp $CONTRIB/score.png $DIR/graphic
cp $CONTRIB/ore,stone,coal.png $DIR/graphic
cp $CONTRIB/ale-title.png $DIR

###############################################################################
##	MISC
###############################################################################

#
#	Compress the sounds
#
find $DIR/sound -type f -name "*.wav" -print -exec $COMPRESS {} \;

#
#	Compress the texts
#
find $DIR/text -type f -name "*.txt" -print -exec $COMPRESS {} \;

#
#	Copy original puds into data directory
#
echo "Copy puds and compressing"
[ -d $DATADIR/../puds ] && cp -r $DATADIR/../puds/ $DIR/puds
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

#
#	Some checks
#
[ -s $DIR/swamp.rgb ] || echo "This script isn't tested with the non-expansion CD!"
