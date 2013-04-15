//       _________ __                 __
//      /   _____//  |_____________ _/  |______     ____  __ __  ______
//      \_____  \\   __\_  __ \__  \\   __\__  \   / ___\|  |  \/  ___/
//      /        \|  |  |  | \// __ \|  |  / __ \_/ /_/  >  |  /\___ |
//     /_______  /|__|  |__|  (____  /__| (____  /\___  /|____//____  >
//             \/                  \/          \//_____/            \/
//  ______________________                           ______________________
//                        T H E   W A R   B E G I N S
//         Stratagus - A free fantasy real time strategy game engine
//
/**@name pudconvert.c - convert PUD files to native stratagus format. */
//
//      (c) Copyright 2005-2011 by The Stratagus Team and Pali Rohár
//
//      This program is free software; you can redistribute it and/or modify
//      it under the terms of the GNU General Public License as published by
//      the Free Software Foundation; only version 2 of the License.
//
//      This program is distributed in the hope that it will be useful,
//      but WITHOUT ANY WARRANTY; without even the implied warranty of
//      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//      GNU General Public License for more details.
//
//      You should have received a copy of the GNU General Public License
//      along with this program; if not, write to the Free Software
//      Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
//      02111-1307, USA.

#include <sys/types.h>
#include <sys/stat.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>

#include "pud.h"

#define VERSION "1.0"

void usage()
{
	fprintf(stderr, "%s\n%s\n",
	"pudconvert V" VERSION,
	"usage: pudconvert inputfile [ outputdir ]\n"
	);
	exit(-1);
}

int main(int argc, char **argv)
{
	if (argc < 2 || argc > 3) {
		usage();
	}

	char *infile = argv[1];
	const char *outdir;
	if (argc == 3) {
		outdir = argv[2];
	} else {
		outdir = ".";
	}

	struct stat sb;
	if (stat(infile, &sb)) {
		fprintf(stderr, "error finding file: %s\n", infile);
		return -1;
	}
	int len = sb.st_size;

	if (stat(outdir, &sb)) {
		fprintf(stderr, "error finding directory: %s\n", outdir);
		return -1;
	}
	FILE *f = fopen(infile, "rb");
	if (f == NULL) {
		fprintf(stderr, "error opening file: %s\n", infile);
		return -1;
	}
	unsigned char *buf = (unsigned char*) malloc(len);
	clearerr(f);
	len = fread(buf, 1, len, f);
	if (ferror(f)) {
		fprintf(stderr, "error reading from file: %s\n", infile);
		free(buf);
		return -1;
	}
	if (fclose(f)) {
		fprintf(stderr, "error closing file: %s\n", infile);
		free(buf);
		return -1;
	}
	char *tmp= strrchr(infile, '/');
	char newname[PATH_MAX];

	if (tmp != NULL) {
		strcpy(newname, tmp + 1);
	} else {
		strcpy(newname, infile);
	}
	tmp = strstr(newname, ".pud");
	if (tmp != NULL) {
		tmp[0] = '\0';
	}
	PudToStratagus(buf, len, newname, outdir);
	free(buf);
	return 0;
}
