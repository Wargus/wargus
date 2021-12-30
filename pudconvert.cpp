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
#include <cstdlib>
#include <cstring>
#include <climits>
#include <iostream>
#include <fstream>

#include "pud.h"

#ifdef WIN32
#include <shlwapi.h>
#else
#include <libgen.h>
#endif

#define VERSION "1.0"

void usage()
{

    std::cerr << "pudconvert V" << VERSION << std::endl << "usage: pudconvert inputfile [ outputdir ]" << std::endl;
	exit(-1);
}

std::vector<unsigned char> read_file_to_vector(const std::filesystem::path &file)
{
    std::vector<unsigned char> out{};
    std::error_code ec{};
    size_t filesize = std::filesystem::file_size(file, ec);
    if (ec) {
        std::cerr << "Failed to get file size for file: " << file << std::endl;
        return out;
    }
    out.resize(filesize);
    std::ifstream f{file, std::ios::binary};
    if (!f.is_open()) {

        std::cerr << "Could not open file: " << file << std::endl;
        return std::vector<unsigned char>();
    }
    f.read(reinterpret_cast<char *>(out.data()), out.size());
    if (f.fail()) {
        std::cerr << "Failed to read from file: " << file << std::endl;
        return std::vector<unsigned char>();
    }
    return out;
}

int main(int argc, char **argv)
{
	if (argc < 2 || argc > 3) {
		usage();
	}

	if (!strcmp(argv[1], "-h") || !strcmp(argv[1], "--help") || !strcmp(argv[1], "/?")) {
		usage();
	}

    std::filesystem::path infile = argv[1];
    std::filesystem::path outdir;


    if (!std::filesystem::exists(infile)) {
        std::cerr << "Error finding file: " << infile << std::endl;
		return -1;
	}
    size_t len = std::filesystem::file_size(infile);

	if (argc == 3) {
		outdir = argv[2];
	} else {
        outdir = infile.parent_path();
	}

    if (!std::filesystem::exists(outdir)) {
        std::cerr << "Error finding directory: " << outdir << std::endl;
		return -1;
	}

    auto buf = read_file_to_vector(infile);
    if (!buf.size()) {
        std::cerr << "Couldn't read file in to vector: " << infile << std::endl;
        return 1;
    }
    std::filesystem::path new_name = infile.filename().replace_extension("");

    PudToStratagus(buf.data(), len, new_name, outdir);
	return 0;
}
