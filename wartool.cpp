//       _________ __                 __
//      /   _____//  |_____________ _/  |______     ____  __ __  ______
//      \_____  \\   __\_  __ \__  \\   __\__  \   / ___\|  |  \/  ___/
//      /        \|  |  |  | \// __ \|  |  / __ \_/ /_/  >  |  /\___ |
//     /_______  /|__|  |__|  (____  /__| (____  /\___  /|____//____  >
//             \/                  \/          \//_____/            \/
//  ______________________                           ______________________
//                        T H E   W A R   B E G I N S
//   Utility for Stratagus - A free fantasy real time strategy game engine
//
/**@name wartool.c - Extract files from war archives. */
//
//      (c) Copyright 1999-2016 by Lutz Sammer, Nehal Mistry, Jimmy Salmon,
//                                 Pali Rohár and cybermind
//
//      This program is free software; you can redistribute it and/or modify
//      it under the terms of the GNU General Public License as published by
//      the Free Software Foundation; version 2 dated June, 1991.
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
//

//@{

/*----------------------------------------------------------------------------
--  Includes
----------------------------------------------------------------------------*/

#include "wargus.h"
#include "wartool.h"
//#include <stratagus-gameutils.h>

#if defined(_MSC_VER) || defined(WIN32)
#include <windows.h>
#endif

#ifdef _MSC_VER
#define DEBUG _DEBUG
#include <direct.h>
#include <io.h>
#else
#define __USE_XOPEN_EXTENDED 1 // to get strdup
#include <unistd.h>
#endif

#include <limits.h>
#include <stdlib.h>

#include "endian.h"
#include "xmi2mid.h"
#include "rip_music.h"
#include "pud.h"

#ifndef __GNUC__
#define __attribute__(args)  // Does nothing for non GNU CC
#endif

#ifndef O_BINARY
#define O_BINARY 0
#endif

#include <string>
#include <iostream>

//FIXME: Remove these later.
/* Some workarounds to avoid depending on Stratagus */

#include <libgen.h> //For dirname

void error(const std::string &header, const std::string &message)
{
    std::cerr << header << ": \n" << message << std::endl;
}

#define SLASH "/"
#if defined(USE_MAC)
#define parentdir(x) strcpy(x, dirname(x))
#else
#define parentdir(x) dirname(x)
#endif

#if __has_include(<filesystem>)
#include <filesystem>
namespace fs = std::filesystem;
#elif __has_include(<experimental/filesystem>)
#include <experimental/filesystem>
namespace fs = std::experimental::filesystem;
#else
error "Missing the <filesystem> header."
#endif

void mkdir_p(const char *path)
{
	fs::create_directories(path);
}

/*End of workarounds */

using byte = unsigned char; //maybe change to std::byte later.

/**
 * @brief The SelfClosingFile class exists to provide and RAII wrapper over a C FILE *, for interoperability with C libraries.
 */
class SelfClosingFile
{
public:
    SelfClosingFile(const std::string &name, const std::string &mode)
    {
        fp = fopen(name.c_str(), mode.c_str());
    }
    ~SelfClosingFile()
    {
        fclose(fp);
    }
    operator FILE *() {return fp;}
    operator bool()const { return fp != nullptr;}
    FILE *fp;
};

class Image
{
public:
    Image(size_t height, size_t width): height{height}, width{width}
    {
        data.resize(height * width);
        fill(0);
    }
    unsigned char &operator[](size_t ind)
    {
        if (ind < data.size()) {
            return data[ind];
        } else {
            std::cerr << "Trying to write out of bounds: " << ind << " when size is: " << data.size() << std::endl;
            abort();
        }
    }
    const unsigned char &operator[](size_t ind)const
    {
        if (ind < data.size()) {
            return data[ind];
        } else {
            std::cerr << "Trying to write out of bounds: " << ind << " when size is: " << data.size() << std::endl;
            abort();
        }
    }
    void fill(unsigned char in)
    {
        std::fill(data.begin(), data.end(), in);
    }

    unsigned char *ptr() {return &data[0];}
    std::vector<unsigned char> data;
    size_t height;
    size_t width;
};


//----------------------------------------------------------------------------

/**
**  Palette N27, for credits cursor
*/
static unsigned char *Pal27;

/**
**  Original archive buffer.
*/
static unsigned char *ArchiveBuffer;

/**
**  Offsets for each entry into original archive buffer.
*/
static unsigned char **ArchiveOffsets;

/**
**  Fake empty entry
*/
static unsigned int EmptyEntry[] = { 1, 1, 1 };


static char *ArchiveDir;

/**
**  What CD Type is it?
*/
static int CDType;

// Width of game font
static int game_font_width;

/**
**  File names.
*/
static char *UnitNames[110];
static int UnitNamesLast = 0;

//----------------------------------------------------------------------------
//  TOOLS
//----------------------------------------------------------------------------

/**
**  Check if path exists, if not make all directories.
*/
void CheckPath(const fs::path &path)
{
    std::error_code error_code;
    if (path.filename().empty()) {
        fs::create_directories(path, error_code);
    } else {
        fs::create_directories(path.parent_path(), error_code);
    }
    if (error_code) {
        std::cerr << "Error in CheckPath, could not create directories!\n" << error_code.message() << std::endl;
    }
}

/**
**  Given a file name that would appear in a PC archive convert it to what
**  would appear on the Mac.
*/
void ConvertToMac(std::string &filename)
{
    if (filename == "rezdat.war") {
        filename = "War Resources";
        return;
    }
    if (filename == "strdat.war") {
        filename = "War Strings";
        return;
    }
    if (filename == "maindat.war") {
        filename = "War Data";
        return;
    }
    if (filename == "snddat.war") {
        filename = "War Music";
        return;
    }
    if (filename == "muddat.cud") {
        filename = "War Movies";
        return;
    }
    if (filename == "sfxdat.sud") {
        filename = "War Sounds";
        return;
    }
}

//----------------------------------------------------------------------------
//  PNG
//----------------------------------------------------------------------------

/**
**  Save a png file.
**
**  @param name         File name
**  @param image        Graphic data
**  @param pal          Palette
**  @param transparent  Image uses transparency
*/
int SavePNG(const fs::path &name,  Image &image, unsigned char *pal, int transparent)
{
    SelfClosingFile fp{name, "wb"};
	png_structp png_ptr;
	png_infop info_ptr;
    std::vector<unsigned char *> lines{};
    size_t i;

    if (!fp) {
        printf("%s:", name.c_str());
		perror("Can't open file");
		fflush(stdout); fflush(stderr);
		return 1;
	}

	png_ptr = png_create_write_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);
	if (!png_ptr) {
		return 1;
	}
	info_ptr = png_create_info_struct(png_ptr);
	if (!info_ptr) {
		png_destroy_write_struct(&png_ptr, NULL);
		return 1;
	}

	if (setjmp(png_jmpbuf(png_ptr))) {
		// FIXME: must free buffers!!
		png_destroy_write_struct(&png_ptr, &info_ptr);
		return 1;
	}
	png_init_io(png_ptr, fp);

	// zlib parameters
	png_set_compression_level(png_ptr, Z_BEST_COMPRESSION);

	// prepare the file information
#if PNG_LIBPNG_VER >= 10504
    png_set_IHDR(png_ptr, info_ptr, image.width, image.height, 8, PNG_COLOR_TYPE_PALETTE, 0,
                 PNG_COMPRESSION_TYPE_DEFAULT, PNG_FILTER_TYPE_DEFAULT);
	png_set_PLTE(png_ptr, info_ptr, (png_colorp)pal, 256);
#else
	info_ptr->width = w;
	info_ptr->height = h;
	info_ptr->bit_depth = 8;
	info_ptr->color_type = PNG_COLOR_TYPE_PALETTE;
	info_ptr->interlace_type = 0;
	info_ptr->valid |= PNG_INFO_PLTE;
	info_ptr->palette = (png_colorp)pal;
	info_ptr->num_palette = 256;
#endif

	if (transparent) {
        unsigned char  *p;
        unsigned char const *end;
		png_byte trans[256];

        p = &image.data[0];
        end = &image.data[0] + (image.height) * image.width;
		while (p < end) {
			if (!*p) {
				*p = 0xFF;
			}
			++p;
		}

		memset(trans, 0xFF, sizeof(trans));
		trans[255] = 0x0;
		png_set_tRNS(png_ptr, info_ptr, trans, 256, 0);
	}

	// write the file header information
	png_write_info(png_ptr, info_ptr);

	// set transformation

	// prepare image
    lines.resize(image.height);
    if (lines.size() != image.height) {
		png_destroy_write_struct(&png_ptr, &info_ptr);
		fclose(fp);
		return 1;
	}

    for (i = 0; i < image.height; ++i) {
        lines[i] = &image.data[0] + (i) * image.width ;
	}

    png_write_image(png_ptr, &lines[0]);
	png_write_end(png_ptr, info_ptr);

	png_destroy_write_struct(&png_ptr, &info_ptr);
	return 0;
}

/**
**  Save a png file.
**
**  @param name         File name
**  @param image        Graphic data
**  @param pal          Palette
**  @param transparent  Image uses transparency
*/
int SavePNG(const fs::path &name, Image &image, int x, int y, int w, int h, int pitch, unsigned char *pal, int transparent)
{
    SelfClosingFile fp{name, "wb"};
    png_structp png_ptr;
    png_infop info_ptr;
    std::vector<unsigned char *> lines{};
    size_t i;

    if (!fp) {
        printf("%s:", name.c_str());
        perror("Can't open file");
        fflush(stdout); fflush(stderr);
        return 1;
    }

    png_ptr = png_create_write_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);
    if (!png_ptr) {
        return 1;
    }
    info_ptr = png_create_info_struct(png_ptr);
    if (!info_ptr) {
        png_destroy_write_struct(&png_ptr, NULL);
        return 1;
    }

    if (setjmp(png_jmpbuf(png_ptr))) {
        // FIXME: must free buffers!!
        png_destroy_write_struct(&png_ptr, &info_ptr);
        return 1;
    }
    png_init_io(png_ptr, fp);

    // zlib parameters
    png_set_compression_level(png_ptr, Z_BEST_COMPRESSION);

    // prepare the file information
#if PNG_LIBPNG_VER >= 10504
    png_set_IHDR(png_ptr, info_ptr, w, h, 8, PNG_COLOR_TYPE_PALETTE, 0,
                 PNG_COMPRESSION_TYPE_DEFAULT, PNG_FILTER_TYPE_DEFAULT);
    png_set_PLTE(png_ptr, info_ptr, (png_colorp)pal, 256);
#else
    info_ptr->width = w;
    info_ptr->height = h;
    info_ptr->bit_depth = 8;
    info_ptr->color_type = PNG_COLOR_TYPE_PALETTE;
    info_ptr->interlace_type = 0;
    info_ptr->valid |= PNG_INFO_PLTE;
    info_ptr->palette = (png_colorp)pal;
    info_ptr->num_palette = 256;
#endif

    if (transparent) {
        unsigned char  *p;
        unsigned char const *end;
        png_byte trans[256];

        p = &image.data[0] + y * pitch + x;
        end = &image.data[0] + (y + h) * pitch + x;
        while (p < end) {
            if (!*p) {
                *p = 0xFF;
            }
            ++p;
        }

        memset(trans, 0xFF, sizeof(trans));
        trans[255] = 0x0;
        png_set_tRNS(png_ptr, info_ptr, trans, 256, 0);
    }

    // write the file header information
    png_write_info(png_ptr, info_ptr);

    // set transformation

    // prepare image
    lines.resize(h);
    if (lines.size() != h) {
        png_destroy_write_struct(&png_ptr, &info_ptr);
        fclose(fp);
        return 1;
    }

    for (i = 0; i < h; ++i) {
        lines[i] = &image.data[0] + (i + y) * pitch + x;
    }

    png_write_image(png_ptr, &lines[0]);
    png_write_end(png_ptr, info_ptr);

    png_destroy_write_struct(&png_ptr, &info_ptr);
    return 0;
}

//----------------------------------------------------------------------------
//  Archive
//----------------------------------------------------------------------------

/**
**  Open the archive file.
**
**  @param file  Archive file name
**  @param type  Archive type requested
*/
int OpenArchive(const char *file, int type)
{
	int f;
	struct stat stat_buf;
    unsigned char *buf;
    unsigned char *cp;
    unsigned char **op;
	int entries;
	int i;

	//
	//  Open the archive file
	//
	f = open(file, O_RDONLY | O_BINARY, 0);
	if (f == -1) {
		error("Can't open file", file);
	}
	if (stat(file, &stat_buf)) {
		error("Can't stat file", file);
	}
    //	printf("Filesize %ld %ldk\n",
    //		(long)stat_buf.st_size, stat_buf.st_size / 1024);

	//
	//  Read in the archive
	//
	buf = (unsigned char *)malloc(stat_buf.st_size);
	if (!buf) {
		printf("Can't malloc %ld\n", (long)stat_buf.st_size);
		error("Memory error", "Could not allocate enough memory to read archive.");
	}
	if (read(f, buf, stat_buf.st_size) != stat_buf.st_size) {
		printf("Can't read %ld\n", (long)stat_buf.st_size);
		error("Memory error", "Could not read archive into RAM.");
	}
	close(f);

	cp = buf;
	i = FetchLE32(cp);
    //	printf("Magic\t%08X\t", i);
	if (i != 0x19) {
		printf("Wrong magic %08x, expected %08x\n", i, 0x00000019);
		error("Archive version error", "This version of the data is not supported");
	}
	entries = FetchLE16(cp);
    //	printf("Entries\t%5d\t", entries);
	i = FetchLE16(cp);
    //	printf("ID\t%d\n", i);
	if (i != type) {
		printf("Wrong type %08x, expected %08x\n", i, type);
		error("Archive version error", "This version of the data is not supported");
	}

	//
	//  Read offsets.
	//
    op = (unsigned char **)malloc((entries + 1) * sizeof(unsigned char *));
	if (!op) {
		printf("Can't malloc %d entries\n", entries);
		error("Memory error", "Could not allocate enough memory to read archive.");
	}
	for (i = 0; i < entries; ++i) {
		op[i] = buf + FetchLE32(cp);
		// check if entry size is not bigger then archive size
		if (op[i] >= buf + stat_buf.st_size - 4) {
			op[i] = (unsigned char *)&EmptyEntry;
			printf("Ignore entry %d in archive (invalid offset)\n", i);
			fflush(stdout);
		} else {
            unsigned char *dp = op[i];
			size_t length = FetchLE32(dp);
			int flags = length >> 24;
			length &= 0x00FFFFFF;
			if (flags == 0x00 && op[i] + length >= buf + stat_buf.st_size) {
				op[i] = (unsigned char *)&EmptyEntry;
				printf("Ignore entry %d in archive (invalid uncompressed length)\n", i);
				fflush(stdout);
			}
		}
        //		printf("Offset\t%d\n", op[i]);
	}
	op[i] = buf + stat_buf.st_size;

	ArchiveOffsets = op;
	ArchiveBuffer = buf;

	return 0;
}

/**
**  Extract/uncompress entry.
**
**  @param cp    Pointer to compressed entry
**  @param lenp  Return pointer of length of the entry
**
**  @return      Pointer to uncompressed entry
*/
unsigned char *ExtractEntry(unsigned char *cp, size_t *lenp)
{
    unsigned char *dp;
    unsigned char *dest;
	size_t uncompressed_length;
	int flags;

	uncompressed_length = FetchLE32(cp);
	flags = uncompressed_length >> 24;
	uncompressed_length &= 0x00FFFFFF;
    //	printf("Entry length %8d flags %02x\t", uncompressed_length, flags);

	dp = dest = (unsigned char *)malloc(uncompressed_length);
	if (!dest) {
		printf("Can't malloc %d\n", (int)uncompressed_length);
		error("Memory error", "Could not allocate enough memory to read archive.");
	}

	if (flags == 0x20) {
		unsigned char buf[8192] = {'\0'};
        unsigned char *ep;
		int bi;

        //		printf("Compressed entry\n");

		bi = 0;
		memset(buf, 0, sizeof(buf));
		ep = dp + uncompressed_length;

		// FIXME: If the decompression is too slow, optimise this loop :->
		while (dp < ep) {
			int i;
			int bflags;

			bflags = FetchByte(cp);
            //			printf("Ctrl %02x ", bflags);
			for (i = 0; i < 8; ++i) {
				int j;
				int o;

				if (bflags & 1) {
					j = FetchByte(cp);
					*dp++ = j;
					buf[bi++ & 0xFFF] = j;
                    //					printf("=%02x", j);
				} else {
					o = FetchLE16(cp);
                    //					printf("*%d,%d", o >> 12, o & 0xFFF);
					j = (o >> 12) + 3;
					o &= 0xFFF;
					while (j--) {
						buf[bi++ & 0xFFF] = *dp++ = buf[o++ & 0xFFF];
						if (dp == ep) {
							break;
						}
					}
				}
				if (dp == ep) {
					break;
				}
				bflags >>= 1;
			}
            //			printf("\n");
		}
		//if (dp != ep) printf("%p,%p %d\n", dp, ep, dp - dest);
	} else if (flags == 0x00) {
        //		printf("Uncompressed entry\n");
		memcpy(dest, cp, uncompressed_length);
	} else {
		printf("Unknown flags %x\n", flags);
		error("Archive version error", "This version of the data is not supported");
	}

	// return resulting length
	if (lenp) {
		*lenp = uncompressed_length;
	}

	return dest;
}

/**
**  Close the archive file.
*/
int CloseArchive(void)
{
	free(ArchiveBuffer);
	free(ArchiveOffsets);
	ArchiveBuffer = 0;
	ArchiveOffsets = 0;

	return 0;
}

#ifdef USE_STORMLIB
int ExtractMPQFile(char *szArchiveName, char *szArchivedFile, char *szFileName, bool compress)
{
	HANDLE hMpq   = NULL;          // Open archive handle
	HANDLE hFile  = NULL;          // Archived file handle
	FILE   *file  = NULL;          // Disk file handle
	gzFile gzfile = NULL;          // Compressed file handle
	int    nError = ERROR_SUCCESS; // Result value

	// Open an archive, e.g. "d2music.mpq"
    if (nError == ERROR_SUCCESS) {
        if (!SFileOpenArchive(szArchiveName, 0, STREAM_FLAG_READ_ONLY, &hMpq)) {
			nError = GetLastError();
        }
    }

	// Open a file in the archive, e.g. "data\global\music\Act1\tristram.wav"
    if (nError == ERROR_SUCCESS) {
        if (!SFileOpenFileEx(hMpq, szArchivedFile, 0, &hFile)) {
			nError = GetLastError();
        }
    }

	// Create the target file
    if (nError == ERROR_SUCCESS) {
		CheckPath(szFileName);
		if (compress) {
			gzfile = gzopen(szFileName, "wb9");
		} else {
			file = fopen(szFileName, "wb");
		}
	}

	// Read the file from the archive
    if (nError == ERROR_SUCCESS) {
		char  szBuffer[0x10000];
		DWORD dwBytes = 1;

        while (dwBytes > 0) {
			SFileReadFile(hFile, szBuffer, sizeof(szBuffer), &dwBytes, NULL);
            if (dwBytes > 0) {
				if (compress) {
					gzwrite(gzfile, szBuffer, dwBytes);
				} else {
					fwrite(szBuffer, 1, dwBytes, file);
				}
			}
		}
	}

	// Cleanup and exit
    if (file != NULL) {
		fclose(file);
	}
    if (gzfile != NULL) {
		gzclose(gzfile);
	}
    if (hFile != NULL) {
		SFileCloseFile(hFile);
    }
    if (hMpq != NULL) {
		SFileCloseArchive(hMpq);
    }

	return nError;
}
#endif

//----------------------------------------------------------------------------
//  Palette
//----------------------------------------------------------------------------

/**
**  Convert palette.
**
**  @param pal  Pointer to palette
**
**  @return     Pointer to palette
*/
unsigned char *ConvertPalette(unsigned char *pal)
{
	int i;

	// PNG needs 0-256
	for (i = 0; i < 768; ++i) {
		pal[i] <<= 2;
	}

	return pal;
}

/**
**  Convert rgb to my format.
*/
int ConvertRgb(const char *file, int rgbe)
{
    unsigned char *rgbp;
    fs::path buf{Dir};
	int i;
	size_t l;

	rgbp = ExtractEntry(ArchiveOffsets[rgbe], &l);
	ConvertPalette(rgbp);

	//
	//  Generate RGB File.
	//
    buf /= TILESET_PATH;
    buf /= file;
    buf.replace_extension(".rgb");
	CheckPath(buf);
    {
        SelfClosingFile f{buf, "wb"};
        if (!f) {
            perror("");
            printf("Can't open %s\n", buf.c_str());
            error("Memory error", "Could not allocate enough memory to read archive.");
        }
        if (l != fwrite(rgbp, 1, l, f)) {
            printf("Can't write %d bytes\n", (int)l);
            fflush(stdout);
        }
	}

	//
	//  Generate GIMP palette
	//
    buf = Dir;
    buf /= TILESET_PATH;
    buf /= file;
    buf.replace_extension(".gimp");
	CheckPath(buf);
    {
        SelfClosingFile f{buf, "wb"};
        if (!f) {
            perror("");
            printf("Can't open %s\n", buf.c_str());
            error("Memory error", "Could not allocate enough memory to read archive.");
        }
        fprintf(f, "GIMP Palette\n# Stratagus %c%s -- GIMP Palette file\n",
                toupper(*file), file + 1);

        for (i = 0; i < 256; ++i) {
            // FIXME: insert nice names!
            fprintf(f, "%d %d %d\t#%d\n",
                    rgbp[i * 3], rgbp[i * 3 + 1], rgbp[i * 3 + 2], i);
        }
	}
	free(rgbp);

	return 0;
}

//----------------------------------------------------------------------------
//  Tileset
//----------------------------------------------------------------------------

/**
**  Decode a minitile into the image.
*/
void DecodeMiniTile(Image &image, int ix, int iy, int iadd,
                    unsigned char *mini, int index, int flipx, int flipy)
{
	static const int flip[] = {
		7, 6, 5, 4, 3, 2, 1, 0, 8
	};
	int x;
	int y;

	for (y = 0; y < 8; ++y) {
		for (x = 0; x < 8; ++x) {
			image[(y + iy * 8) * iadd + ix * 8 + x] = mini[index +
                                                           (flipy ? flip[y] : y) * 8 + (flipx ? flip[x] : x)];
		}
	}
}

/**
**  Convert tiles into image.
*/
Image ConvertTile(unsigned char *mini, const unsigned char *mega, int msize)
{
    const unsigned short *mp;
    size_t height;
    size_t width;
	int i;
	int x;
	int y;
	int offset;
	int numtiles;

    //	printf("Tiles in mega %d\t", msize / 32);
	numtiles = msize / 32;

	width = TILE_PER_ROW * 32;
	height = ((numtiles + TILE_PER_ROW - 1) / TILE_PER_ROW) * 32;
    //	printf("Image %dx%d\n", width, height);
    Image image{height, width};

	for (i = 0; i < numtiles; ++i) {
		//mp = (const unsigned short*)(mega + img2tile[i] * 32);
        mp = (const unsigned short *)(mega + i * 32);
		if (i < 16) {  // fog of war
			for (y = 0; y < 32; ++y) {
				offset = i * 32 * 32 + y * 32;
                std::memcpy(image.ptr() + (i % TILE_PER_ROW) * 32 +
                            (((i / TILE_PER_ROW) * 32) + y) * width,
                            mini + offset, 32);
			}
		} else {  // normal tile
			for (y = 0; y < 4; ++y) {
				for (x = 0; x < 4; ++x) {
					offset = ConvertLE16(mp[x + y * 4]);
					DecodeMiniTile(image,
                                   x + ((i % TILE_PER_ROW) * 4), y + (i / TILE_PER_ROW) * 4, width,
                                   mini, (offset & 0xFFFC) * 16, offset & 2, offset & 1);
				}
			}
		}
	}

	return image;
}

/**
**  Convert a tileset to my format.
*/
int ConvertTileset(const char *file, int pale, int mege, int mine, int mape)
{
    unsigned char *palp;
    unsigned char *megp;
    unsigned char *minp;
    unsigned char *mapp;
	size_t megl;
    fs::path buf{};

	palp = ExtractEntry(ArchiveOffsets[pale], NULL);
	megp = ExtractEntry(ArchiveOffsets[mege], &megl);
	minp = ExtractEntry(ArchiveOffsets[mine], NULL);
	mapp = ExtractEntry(ArchiveOffsets[mape], NULL);

    //	printf("%s:\t", file);
    Image image = ConvertTile(minp, megp, megl);

	free(megp);
	free(minp);
	free(mapp);

	ConvertPalette(palp);
    buf = Dir;
    buf /= TILESET_PATH;
    buf /= file;
    buf.replace_extension(".png");
	CheckPath(buf);
    SavePNG(buf, image, palp, 1);

	free(palp);

	return 0;
}

//----------------------------------------------------------------------------
//  Graphics
//----------------------------------------------------------------------------

/**
**  Decode a entry(frame) into image.
*/
void DecodeGfxEntry(int index, unsigned char *start,
                    unsigned char *image, int ix, int iy, int iadd)
{
    unsigned char *bp;
    unsigned char *sp;
    unsigned char *dp;
	int xoff;
	int yoff;
	int width;
	int height;
	int offset;
    unsigned char *rows;
	int h;
	int w;
	int ctrl;

	bp = start + index * 8;
	xoff = FetchByte(bp);
	yoff = FetchByte(bp);
	width = FetchByte(bp);
	height = FetchByte(bp);
	offset = FetchLE32(bp);

    //	printf("%2d: +x %2d +y %2d width %2d height %2d offset %d\n",
    //		index, xoff, yoff, width, height, offset);

	rows = start + offset - 6;
	dp = image + xoff - ix + (yoff - iy) * iadd;

	for (h = 0; h < height; ++h) {
        //		printf("%2d: row-offset %2d\t", index, AccessLE16(rows + h * 2));
		sp = rows + AccessLE16(rows + h * 2);
        for (w = 0; w < width;) {
			ctrl = *sp++;
            //			printf("%02X", ctrl);
			if (ctrl & 0x80) {  // transparent
				ctrl &= 0x7F;
                //				printf("-%d,", ctrl);
                memset(dp + h * iadd + w, 255, ctrl);
                w += ctrl;
			} else if (ctrl & 0x40) {  // repeat
				ctrl &= 0x3F;
                //				printf("*%d,", ctrl);
				memset(dp + h * iadd + w, *sp++, ctrl);
				w += ctrl;
			} else {						// set pixels
				ctrl &= 0x3F;
                //				printf("=%d,", ctrl);
				memcpy(dp + h * iadd + w, sp, ctrl);
				sp += ctrl;
				w += ctrl;
			}
		}
		//dp[h * iadd + width - 1] = 0;
        //		printf("\n");
	}
}

/**
**  Decode a entry(frame) into image.
*/
void DecodeGfuEntry(int index, unsigned char *start,
                    unsigned char *image, int ix, int iy, int iadd)
{
    unsigned char *bp;
    unsigned char *sp;
    unsigned char *dp;
	int i;
	int xoff;
	int yoff;
	int width;
	int height;
	int offset;

	bp = start + index * 8;
	xoff = FetchByte(bp);
	yoff = FetchByte(bp);
	width = FetchByte(bp);
	height = FetchByte(bp);
	offset = FetchLE32(bp);
	// High bit of width
	if (offset < 0) {
		offset &= 0x7FFFFFFF;
		width += 256;
	}

    //	printf("%2d: +x %2d +y %2d width %2d height %2d offset %d\n",
    //		index, xoff, yoff, width, height, offset);

	sp = start + offset - 6;
	dp = image + xoff - ix + (yoff - iy) * iadd;
	for (i = 0; i < height; ++i) {
		memcpy(dp, sp, width);
		dp += iadd;
		sp += width;
	}
}

/**
**  Convert graphics into image.
*/
Image ConvertGraphic(int gfx, unsigned char *bp,
                     unsigned char *bp2, int start2)
{
    size_t i;
    size_t count;
    size_t length;
    size_t max_width;
    size_t max_height;
    size_t minx;
    size_t miny;
    size_t best_width;
    size_t best_height;
    size_t IPR;

	// Init pointer to 2nd animation
	if (bp2) {
		count = FetchLE16(bp2);
		max_width = FetchLE16(bp2);
		max_height = FetchLE16(bp2);
	}
	count = FetchLE16(bp);
	max_width = FetchLE16(bp);
	max_height = FetchLE16(bp);


    //	printf("Entries %2d Max width %3d height %3d, ", count,
    //		max_width, max_height);

	// Find best image size
	minx = 999;
	miny = 999;
	best_width = 0;
	best_height = 0;
	for (i = 0; i < count; ++i) {
        unsigned char *p;
		int xoff;
		int yoff;
		int width;
		int height;

		p = bp + i * 8;
		xoff = FetchByte(p);
		yoff = FetchByte(p);
		width = FetchByte(p);
		height = FetchByte(p);
		// high bit of width
		if (AccessLE32(p) & 0x80000000) {
			width += 256;
		}
		// increase p by 32bits, as AccessLE32 cannot do it above.
		p += 4;
		if (xoff < minx) {
			minx = xoff;
		}
		if (yoff < miny) {
			miny = yoff;
		}
		if (xoff + width > best_width) {
			best_width = xoff + width;
		}
		if (yoff + height > best_height) {
			best_height = yoff + height;
		}
	}
	// FIXME: the image isn't centered!!

#if 0
	// Taken out, must be rewritten.
	if (max_width - best_width < minx) {
		minx = max_width - best_width;
		best_width -= minx;
	} else {
		best_width = max_width - minx;
	}
	if (max_height - best_height < miny) {
		miny = max_height - best_height;
		best_height -= miny;
	} else {
		best_height = max_width - miny;
	}

	//best_width -= minx;
	//best_height -= miny;
#endif

    //	printf("Best image size %3d, %3d\n", best_width, best_height);

	minx = 0;
	miny = 0;

	if (gfx) {
		best_width = max_width;
		best_height = max_height;
		IPR = 5;  // st*rcr*ft 17!
		if (count < IPR) {  // images per row !!
			IPR = 1;
			length = count;
		} else {
			length = ((count + IPR - 1) / IPR) * IPR;
		}
	} else {
		max_width = best_width;
		max_height = best_height;
		IPR = 1;
		length = count;
	}

    //  Image: 0, 1, 2, 3, 4,
    //         5, 6, 7, 8, 9, ...
    // Set all to transparent.
    Image image{best_height *(length / IPR),	best_width * IPR};
    image.fill(255);


	if (gfx) {
		for (i = 0; i < count; ++i) {
			// Hardcoded support for worker with resource repairing
			if (i >= start2 && bp2) {
				DecodeGfxEntry(i, bp2,
                               image.ptr() + best_width * (i % IPR) + best_height * best_width * IPR * (i / IPR),
                               minx, miny, best_width * IPR);
			} else {
				DecodeGfxEntry(i, bp,
                               image.ptr() + best_width * (i % IPR) + best_height * best_width * IPR * (i / IPR),
                               minx, miny, best_width * IPR);
			}
		}
	} else {
		for (i = 0; i < count; ++i) {
			DecodeGfuEntry(i, bp,
                           image.ptr() + best_width * (i % IPR) + best_height * best_width * IPR * (i / IPR),
                           minx, miny, best_width * IPR);
		}
	}

	return image;
}

/**
**  Convert a graphic to my format.
*/
int ConvertGfx(const char *file, int pale, int gfxe, int gfxe2, int start2)
{
    unsigned char *palp;
    unsigned char *gfxp;
    unsigned char *gfxp2;

	char buf[1024];

	palp = ExtractEntry(ArchiveOffsets[pale], NULL);
	gfxp = ExtractEntry(ArchiveOffsets[gfxe], NULL);
	if (gfxe2) {
		gfxp2 = ExtractEntry(ArchiveOffsets[gfxe2], NULL);
	} else {
		gfxp2 = NULL;
	}

    auto image = ConvertGraphic(1, gfxp, gfxp2, start2);

	if (gfxp2) {
		free(gfxp2);
	}

	free(gfxp);
	ConvertPalette(palp);

    sprintf(buf, "%s/%s/%s.png", Dir.c_str(), GRAPHICS_PATH, file);
	CheckPath(buf);
    SavePNG(buf, image, palp, 1);

	free(palp);

	return 0;
}

/**
**  Convert a uncompressed graphic to my format.
*/
int ConvertGfu(const char *file, int pale, int gfue)
{
    unsigned char *palp;
    unsigned char *gfup;
    fs::path buf;

	palp = ExtractEntry(ArchiveOffsets[pale], NULL);
	gfup = ExtractEntry(ArchiveOffsets[gfue], NULL);

    auto image = ConvertGraphic(0, gfup, NULL, 0);

	free(gfup);
	ConvertPalette(palp);
    buf = Dir;
    buf /= GRAPHICS_PATH;
    buf /= file;
    buf.replace_extension(".png");
	CheckPath(buf);
    SavePNG(buf, image, palp, 1);

	free(palp);

	return 0;
}

/**
**  Split up and convert uncompressed graphics to seperate PNGs
*/
int ConvertGroupedGfu(const char *path, int pale, int gfue, int glist)
{
    unsigned char *palp;
    unsigned char *gfup;
    size_t w;
    size_t h;
	int i;
	const GroupedGraphic *gg;

	palp = ExtractEntry(ArchiveOffsets[pale], NULL);
	gfup = ExtractEntry(ArchiveOffsets[gfue], NULL);

    auto image = ConvertGraphic(0, gfup, NULL, 0);
    w = image.width;
    h = image.height;

	free(gfup);
	ConvertPalette(palp);

	for (i = 0; GroupedGraphicsList[glist][i].Name[0]; ++i) {
		gg = &GroupedGraphicsList[glist][i];

		// hack for expansion/original difference
		if (gg->Y + gg->Height > h) {
			break;
		}

		// hack for multiple palettes
		if (i == 3 && strstr(path, "widgets")) {
			free(palp);
			palp = ExtractEntry(ArchiveOffsets[14], NULL);
			ConvertPalette(palp);
		}
        fs::path buf{};
        buf = Dir;
        buf /= GRAPHICS_PATH;
        buf /= path;
        buf /= gg->Name;
        buf.replace_extension(".png");
		CheckPath(buf);
        SavePNG(buf, image, gg->X, gg->Y, gg->Width, gg->Height, image.width, palp, 1);
	}

	free(palp);

	return 0;
}

//----------------------------------------------------------------------------
//  Puds
//----------------------------------------------------------------------------

/**
**  Convert pud to my format.
*/
void ConvertPud(const fs::path file, int pude, bool justconvert = false)
{
    unsigned char *pudp = NULL;
    fs::path buf{};
    size_t l;

	if (justconvert == false) {
		pudp = ExtractEntry(ArchiveOffsets[pude], &l);
        buf = Dir;
        buf /= PUD_PATH;
        buf /= file;
		CheckPath(buf);
        //FIXME: Check that this makes sense.
        // Here I am assuming that the strrchr below was to get the parent path.
        buf = buf.parent_path();
        // *strrchr(buf, '/') = '\0';

        PudToStratagus(pudp, l, /*strrchr(file, '/') + 1-- this should be just the file part.*/ file.filename().c_str(), buf.c_str());
	} else {
        fs::path pudfile{};
		size_t filesize = 0;
        buf = Dir;
        buf /= file;
        pudfile = buf;
		CheckPath(buf);
        if (!fs::exists(buf)) {
            printf("Can't open pud file: %s\n", buf.c_str());
			return;
		}
        filesize = fs::file_size(buf);
        SelfClosingFile f{buf, "rb"};
		if (!f) {
            printf("Can't open pud file: %s\n", buf.c_str());
			return;
		}
        std::vector<unsigned char> pudp{}; // Really should maybe mmap this.
        pudp.resize(filesize);
        if (fread(&pudp[0], 1, filesize, f) != filesize) {
            printf("Error reading pud file: %s\n", buf.c_str());
			return;
		}
        //FIXME: See Note above.
        buf = buf.parent_path();
        //*strrchr(buf, '/') = '\0';

        PudToStratagus(&pudp[0], filesize, /*strrchr(file, '/') + 1--Similar to above*/ file.filename().c_str(), buf.c_str());
#ifdef WIN32
		_unlink(pudfile);
#else
        unlink(pudfile.c_str());
#endif
	}
}

/**
**	Convert puds that are in their own file
*/
void ConvertFilePuds(const char **pudlist)
{
	char pudname[8192] = {'\0'};
	char base[8192] = {'\0'};
	char outdir[8192] = {'\0'};
	unsigned char *puddata;
	struct stat sb;
	int i;

	for (i = 0; pudlist[i][0] != '\0'; ++i) {
		char origname[8192] = {'\0'};
		if (CDType & CD_UPPER) {
			char filename[8192] = {'\0'};
			int j = 0;
			strcpy(filename, pudlist[i]);
			strcpy(origname, pudlist[i]);
			while (filename[j]) {
				filename[j] = toupper(filename[j]);
				++j;
			}
			pudlist[i] = filename;
		}
		sprintf(pudname, "%s/%s", ArchiveDir, pudlist[i]);
		if (stat(pudname, &sb)) {
			continue;
		}
        {
            SelfClosingFile f{pudname, "rb"};
            if (!f) {
                return;
            }
            puddata = (unsigned char *)malloc(sb.st_size);
            if (!puddata) {
                return;
            }
            if (!fread(puddata, 1, sb.st_size, f)) {
                return;
            }
		}

		strcpy(base, strrchr(pudlist[i], '/') + 1);

		if (CDType & CD_UPPER) {
			*strstr(base, ".PUD") = '\0';
			pudlist[i] = origname;
		} else {
			*strstr(base, ".pud") = '\0';
		}

		if (strstr(pudlist[i], "puds/")) {
            sprintf(outdir, "%s/maps/%s", Dir.c_str(), strstr(pudlist[i], "puds/") + 5);
			*strrchr(outdir, '/') = '\0';
		} else {
            sprintf(outdir, "%s/maps", Dir.c_str());
		}

		strcpy(pudname, outdir);
		strcat(pudname, "/dummy");
		CheckPath(pudname);

		PudToStratagus(puddata, (size_t)(sb.st_size), base, outdir);
		free(puddata);
	}
}

//----------------------------------------------------------------------------
//  Font
//----------------------------------------------------------------------------

/**
**  Convert font into image.
*/
Image ConvertFnt(unsigned char *start)
{
	int i;
	int count;
	int max_width;
	int max_height;
	int width;
	int height;
	int xoff;
	int yoff;
    unsigned char *bp;
    unsigned char *dp;
    size_t image_width;
    size_t image_height;
	int IPR;
    int h; int w;

	bp = start + 5;  // skip "FONT "
	count = FetchByte(bp);
	if (CDType & CD_RUSSIAN) {
		// hack to show last letter in font
		count -= 31;
	} else {
		count -= 32;
	}

	max_width = FetchByte(bp);
	max_height = FetchByte(bp);

	IPR = 15;  // 15 characters per row
	image_width = max_width * IPR;
	image_height = (count + IPR - 1) / IPR * max_height;

    //	printf("Font: count %d max-width %2d max-height %2d\n",
    //		count, max_width, max_height);

    std::vector<uint32_t> offsets;
    offsets.resize(count);
	for (i = 0; i < count; ++i) {
		offsets[i] = FetchLE32(bp);
        //		printf("%03d: offset %d\n", i, offsets[i]);
	}

    Image image{image_height, image_width};
    image.fill(255);

	for (i = 0; i < count; ++i) {
		if (!offsets[i]) {
            //			printf("%03d: unused\n", i);
			continue;
		}
		bp = start + offsets[i];
		width = FetchByte(bp);
		height = FetchByte(bp);
		xoff = FetchByte(bp);
		yoff = FetchByte(bp);

        //		printf("%03d: width %d height %d xoff %d yoff %d\n",
        //			i, width, height, xoff, yoff);

        dp = image.ptr() + (i % IPR) * max_width + (i / IPR) * image_width * max_height;
		dp += xoff + yoff * image_width;
		h = w = 0;
		bool toBreak = false;
		for (;;) {
			int ctrl;

			ctrl = FetchByte(bp);
            //			printf("%d,%d ", ctrl >> 3, ctrl & 7);
			w += (ctrl >> 3) & 0x1F;
			while (w >= width) {
                //				printf("\n");
				w -= width;
				++h;
				if (h >= height) {
					toBreak = true;
					break;
				}
			}
			if (toBreak) {
				break;
			}
			dp[h * image_width + w] = ctrl & 0x07;
			++w;
			if (w >= width) {
                //				printf("\n");
				w -= width;
				++h;
				if (h >= height) {
					break;
				}
			}
		}
	}


	return image;
}

/**
**  Fix fonts for Russian SPK version.
*/
void FixFont(Image &image)
{
    size_t w = image.width;
    size_t h = image.height;
	const int fontWidth = w / 15;
	const int fontHeight = h / 14;
	// First block of 3 lowercase letters at 168,168
	for (int i = 0; i < fontHeight; ++i) {
        unsigned char *pi = &image[w * (12 * fontHeight + i) + fontWidth * 12];
        unsigned char *po = &image[w * (9 * fontHeight + i) + fontWidth * 9];
		for (int j = 0; j < 3 * fontWidth; ++j) {
			*po++ = *pi++;
		}
	}
	// Second block of 3 lowercase letters at 0,182
	for (int i = 0; i < fontHeight; ++i) {
        unsigned char *pi = &image[w * (13 * fontHeight + i) + fontWidth * 0];
        unsigned char *po = &image[w * (9 * fontHeight + i) + fontWidth * 12];
		for (int j = 0; j < 3 * fontWidth; ++j) {
			*po++ = *pi++;
		}
	}
	// Third block of 7 lowercase letters at 42,182
	for (int i = 0; i < fontHeight; ++i) {
        unsigned char *pi = &image[w * (13 * fontHeight + i) + fontWidth * 3];
        unsigned char *po = &image[w * (10 * fontHeight + i) + fontWidth * 0];
		for (int j = 0; j < 10 * fontWidth; ++j) {
			*po++ = *pi++;
		}
	}
}

/**
**  Convert a font to my format.
*/
int ConvertFont(const char *file, int pale, int fnte)
{
    unsigned char *palp;
    unsigned char *fntp;
	int w;
	int h;
    fs::path buf{};

	palp = ExtractEntry(ArchiveOffsets[pale], NULL);
	fntp = ExtractEntry(ArchiveOffsets[fnte], NULL);

    auto image = ConvertFnt(fntp);

	free(fntp);
	ConvertPalette(palp);

    buf = Dir;
    buf /= FONT_PATH;
    buf /= file;
    buf.replace_extension(".png");
	CheckPath(buf);
	if (!strcmp(file, "game")) {
		game_font_width = w / 15;
	}
	if (CDType & CD_RUSSIAN) {
        FixFont(image);
	}
    SavePNG(buf, image, palp, 1);

	free(palp);

	return 0;
}

//----------------------------------------------------------------------------
//  Image
//----------------------------------------------------------------------------

/**
**  Convert image into image.
*/
Image ConvertImg(unsigned char *bp)
{
    size_t width;
    size_t height;

	width = FetchLE16(bp);
	height = FetchLE16(bp);

    //	printf("Image: width %3d height %3d\n", width, height);

    Image image{height, width};
    std::memcpy(&image[0], bp, image.data.size());

    return image;
}

/**
**  Resize an image
**
**  @param image  image data to be converted
**  @param ow     old image width
**  @param oh     old image height
**  @param nw     new image width
**  @param nh     new image height
*/
Image ResizeImage(const Image &image, size_t nw, size_t nh)
{


    if (image.width == nw && nh == image.height) {
        return image;
	}
    Image out{nh, nw};
    out.fill(0);

    size_t x = 0;
    for (size_t i = 0; i < nh; ++i) {
        for (size_t j = 0; j < nw; ++j) {
            out[x] = image [i * image.height / nh * image.width + j * image.width / nw];
			++x;
		}
	}
    return out;
}

/**
**  Convert an image to my format.
*/
int ConvertImage(const char *file, int pale, int imge, int nw, int nh)
{
    unsigned char *palp;
    unsigned char *imgp;

	// Workaround for MAC expansion CD
	if (CDType & CD_MAC) {
		if (imge >= 94 && imge <= 103) {
			imge += 7;
		}
		if (pale == 93) {
			pale += 7;
		}
	}

	palp = ExtractEntry(ArchiveOffsets[pale], NULL);
	if (pale == 27 && imge == 28) {
		Pal27 = palp;
	}
	imgp = ExtractEntry(ArchiveOffsets[imge], NULL);

    auto image = ConvertImg(imgp);


	free(imgp);
	ConvertPalette(palp);

    fs::path buf;
    buf = Dir;
    buf /= GRAPHIC_PATH;
    buf /= file;
    buf.replace_extension(".png");
	CheckPath(buf);

	// Only resize if parameters 3 and 4 are non-zero
	if (nw && nh) {
        image = ResizeImage(image, nw, nh);
	}
    SavePNG(buf, image, palp, 0);

	if (pale != 27 || imge != 28) {
		free(palp);
	}

	return 0;
}

//----------------------------------------------------------------------------
//  Cursor
//----------------------------------------------------------------------------

/**
**  Convert cursor into image.
*/
Image ConvertCur(unsigned char *bp)
{
	int hotx;
	int hoty;
    size_t width;
    size_t height;

	hotx = FetchLE16(bp);
	hoty = FetchLE16(bp);
	width = FetchLE16(bp);
	height = FetchLE16(bp);

    //	printf("Cursor: hotx %d hoty %d width %d height %d\n",
    //		hotx, hoty, width, height);

    Image image{height, width};

    for (size_t i = 0; i < width * height; ++i) {
		image[i] = bp[i] ? bp[i] : 255;
	}



	return image;
}

/**
**  Convert a cursor to my format.
*/
int ConvertCursor(const char *file, int pale, int cure)
{
    unsigned char *palp;
    unsigned char *curp;
    fs::path buf{};

    if (pale == 27 && cure == 314 && Pal27) {  // Credits arrow (Blue arrow NW)
		palp = Pal27;
	} else {
		palp = ExtractEntry(ArchiveOffsets[pale], NULL);
	}
	curp = ExtractEntry(ArchiveOffsets[cure], NULL);

    auto image = ConvertCur(curp);

	free(curp);
	ConvertPalette(palp);
    buf = Dir;
    buf /= CURSOR_PATH;
    buf /= file;
    buf.replace_extension(".png");
	CheckPath(buf);
    SavePNG(buf, image, palp, 1);

	if (pale != 27 || cure != 314 || !Pal27) {
		free(palp);
	}

	return 0;
}

//----------------------------------------------------------------------------
//  Wav
//----------------------------------------------------------------------------

/**
**  Extract Wav
*/
int ConvertWav(const fs::path &file, int wave)
{
    unsigned char *wavp;
    fs::path buf{};
	gzFile gf;
	size_t l;

	wavp = ExtractEntry(ArchiveOffsets[wave], &l);
    buf = Dir;
    buf /= SOUND_PATH;
    buf /= file;
    buf.replace_extension(".wav.gz");
	CheckPath(buf);
    gf = gzopen(buf.c_str(), "wb9");
	if (!gf) {
		perror("");
        printf("Can't open %s\n", buf.c_str());
		error("Memory error", "Could not allocate enough memory to read archive.");
	}
	if (l != (size_t)gzwrite(gf, wavp, l)) {
		printf("Can't write %d bytes\n", (int)l);
		fflush(stdout);
	}

	free(wavp);

	gzclose(gf);
	return 0;
}

//----------------------------------------------------------------------------
//  XMI Midi
//----------------------------------------------------------------------------

/**
**  Convert XMI Midi sound to GM MIDI
*/

int ConvertXmi(const fs::path &file, int xmi)
{
    unsigned char *xmip;
    unsigned char *midp;
    fs::path buf{};
	size_t xmil;
	size_t midl;

	xmip = ExtractEntry(ArchiveOffsets[xmi], &xmil);
	midp = TranscodeXmiToMid(xmip, xmil, &midl);
	free(xmip);
    buf = Dir;
    buf /= MUSIC_PATH;
    buf /= file;
    buf.replace_extension(".mid");
	CheckPath(buf);
    SelfClosingFile f{buf, "wb"};
	if (!f) {
		perror("");
        printf("Can't open %s\n", buf.c_str());
		error("Memory error", "Could not allocate enough memory to read archive.");
	}
	if (midl != fwrite(midp, 1, midl, f)) {
		printf("Can't write %d bytes\n", (int)midl);
		fflush(stdout);
	}

	free(midp);

	return 0;
}

//----------------------------------------------------------------------------
//  Ripped music
//----------------------------------------------------------------------------


/**
**  Copy file
*/

#if ! defined(_MSC_VER) && ! defined(WIN32)
int CopyFile(char *from, char *to, int overwrite)
{
    std::error_code ec;
    if (overwrite) {
        fs::copy_file(from, to, fs::copy_options::overwrite_existing, ec);
    } else {
        fs::copy_file(from, to, fs::copy_options::skip_existing, ec);
    }

    if (ec) {
        std::cerr << ec.message() << std::endl;
        return 1;
    }
    return 0;
}
#endif

/**
**  Copy ripped music
*/

int CopyMusic(void)
{
	struct stat st;
	char buf1[8192] = {'\0'};
	char buf2[8192] = {'\0'};
	char ext[4];
	int i;
	int count = 0;

    for (i = 0; !MusicNames[i].empty(); ++i) {
		strcpy(ext, "wav");
        sprintf(buf1, "%s/music/%s.%s", ArchiveDir, MusicNames[i].c_str(), ext);
		if (stat(buf1, &st)) {
			strcpy(ext, "ogg");
            sprintf(buf1, "%s/music/%s.%s", ArchiveDir, MusicNames[i].c_str(), ext);
            if (stat(buf1, &st)) {
				continue;
            }
        }

		printf("Found ripped music file \"%s\"\n", buf1);
		fflush(stdout);

        sprintf(buf2, "%s/%s/%s.%s", Dir.c_str(), MUSIC_PATH, MusicNames[i].c_str(), ext);
		CheckPath(buf2);
        if (CopyFile(buf1, buf2, 0)) {
			++count;
        }
    }

    if (count == 0) {
		return 1;
    } else {
		return 0;
    }
}

/**
**  Convert Ripped WAV music files to OGG
*/

int ConvertMusic(void)
{
	struct stat st;
	char buf[8192] = {'\0'};
	char *cmd;
	int cmdlen;
	int ret, i;
	int count = 0;

    for (i = 0; !MusicNames[i].empty(); ++i) {
        snprintf(buf, 4095, "%s/%s/%s.wav", Dir.c_str(), MUSIC_PATH, MusicNames[i].c_str());
		CheckPath(buf);

        if (stat(buf, &st)) {
			continue;
        }

		cmdlen = strlen("ffmpeg -y -i \"") + strlen(buf) + strlen("\" \"") + strlen(buf) + strlen("\" ");
        cmd = (char *) calloc(cmdlen + 1, 1);
		if (!cmd) {
			fprintf(stderr, "Memory error\n");
			error("Memory error", "Could not allocate enough memory to read archive.");
		}

        snprintf(cmd, cmdlen, "ffmpeg -y -i \"%s\" \"%s/%s/%s.ogg\"", buf, Dir.c_str(), MUSIC_PATH, MusicNames[i].c_str());

		ret = system(cmd);

		free(cmd);
		remove(buf);

		if (ret != 0) {
            printf("Can't convert wav sound %s to ogg format. Is ffmpeg installed in PATH?\n", MusicNames[i].c_str());
			fflush(stdout);
		}

		++count;
	}
	if (CDType & CD_BNE) {
        for (i = 0; !BNEMusicNames[i].empty(); ++i) {
            sprintf(buf, "%s/%s/%s.wav", Dir.c_str(), MUSIC_PATH, BNEMusicNames[i].c_str());
			CheckPath(buf);

            if (stat(buf, &st)) {
				continue;
            }

			cmdlen = strlen("ffmpeg -y -i \"") + strlen(buf) + strlen("\" \"") + strlen(buf) + strlen("\" ");
            cmd = (char *) calloc(cmdlen + 1, 1);
			if (!cmd) {
				fprintf(stderr, "Memory error\n");
				error("Memory error", "Could not allocate enough memory to read archive.");
			}

            snprintf(cmd, cmdlen, "ffmpeg -y -i \"%s\" \"%s/%s/%s.ogg\"", buf, Dir.c_str(), MUSIC_PATH, BNEMusicNames[i].c_str());

			ret = system(cmd);

			free(cmd);
			remove(buf);

			if (ret != 0) {
                printf("Can't convert wav sound %s to ogg format. Is ffmpeg installed in PATH?\n", BNEMusicNames[i].c_str());
				fflush(stdout);
			}

			++count;
		}
	}

    if (count == 0) {
		return 1;
    } else {
		return 0;
    }
}

//----------------------------------------------------------------------------
//  Video
//----------------------------------------------------------------------------

/**
**  Convert SMK video to OGV
*/
int ConvertVideo(const char *file, int video, bool justconvert = false)
{
    unsigned char *vidp;
	char buf[8192] = {'\0'};
    char *cmd;
    FILE *f;
	size_t l;
	int ret;
	int cmdlen;
	char outputfile[8192] = {'\0'};

    snprintf(buf, 4095, "%s/%s.smk", Dir.c_str(), file);
	CheckPath(buf);
	if (justconvert == false) {
		vidp = ExtractEntry(ArchiveOffsets[video], &l);

		f = fopen(buf, "wb");
		if (!f) {
			perror("");
			printf("Can't open %s\n", buf);
			error("Memory error", "Could not allocate enough memory to read archive.");
		}
		if (l != fwrite(vidp, 1, l, f)) {
			printf("Can't write %d bytes\n", (int)l);
			fflush(stdout);
		}

		free(vidp);
		fclose(f);
	}

	if (CDType & CD_BNE) {
		cmdlen = strlen("ffmpeg -y -i \"") + strlen(buf) + strlen("\" -codec:v libtheora -qscale:v 31 -codec:a libvorbis -qscale:a 15 -pix_fmt yuv420p -aspect 4:3 -vf scale=640x0,setsar=1:1 \"") + strlen(buf) + strlen("\" ");
	} else {
		cmdlen = strlen("ffmpeg -y -i \"") + strlen(buf) + strlen("\" -codec:v libtheora -qscale:v 31 -codec:a libvorbis -qscale:a 15 -pix_fmt yuv420p \"") + strlen(buf) + strlen("\" ");
	}
    cmd = (char *) calloc(cmdlen + 1, 1);
	if (!cmd) {
		fprintf(stderr, "Memory error\n");
		error("Memory error", "Could not allocate enough memory to read archive.");
	}

	if (CDType & CD_BNE) {
        snprintf(cmd, cmdlen, "ffmpeg -y -i \"%s/%s.smk\" -codec:v libtheora -qscale:v 31 -codec:a libvorbis -qscale:a 15 -pix_fmt yuv420p -aspect 4:3 -vf scale=640:0,setsar=1:1 \"%s/%s.ogv\"", Dir.c_str(), file, Dir.c_str(), file);
	} else {
        snprintf(cmd, cmdlen, "ffmpeg -y -i \"%s/%s.smk\" -codec:v libtheora -qscale:v 31 -codec:a libvorbis -qscale:a 15 -pix_fmt yuv420p \"%s/%s.ogv\"", Dir.c_str(), file, Dir.c_str(), file);
	}
	printf("%s\n", cmd);
	ret = system(cmd);

	free(cmd);
	remove(buf);

	if (ret != 0) {
        sprintf(outputfile, "%s/%s.ogv", Dir.c_str(), file);
#ifdef WIN32
		_unlink(outputfile);
#else
		unlink(outputfile);
#endif
		printf("Can't convert video %s to ogv format. Is ffmpeg installed in PATH?\n", file);
		fflush(stdout);
		return ret;
	}

	return 0;
}

//----------------------------------------------------------------------------
//  Text
//----------------------------------------------------------------------------

/**
**  Convert a string to utf8 format
**  Note: this isn't a true conversion, buf could be any character set
*/
unsigned char *ConvertString(unsigned char *buf, size_t len)
{
	unsigned char *str;
	unsigned char *p;
	size_t i;

	if (len == 0) {
		len = strlen((char *)buf);
	}

	str = (unsigned char *)malloc(2 * len + 1);
	p = str;

	for (i = 0; i < len; ++i, ++buf) {
		if (*buf > 0x7f) {
			if (CDType & (CD_RUSSIAN)) {
				// Special cp866 hack for SPK version
				*p++ = 0xc2;
				if (*buf >= 0xE0 && *buf < 0xF0) {
					*p++ = *buf - 0x30;
				} else {
					*p++ = *buf;
				}
			} else {
				*p++ = (0xc0 | (*buf >> 6));
				*p++ = (0x80 | (*buf & 0x1f));
			}
		} else {
			*p++ = *buf;
		}
	}
	*p = '\0';

	return str;
}

/**
**  Convert text to my format.
*/
int ConvertText(const char *file, int txte, int ofs)
{
    unsigned char *txtp;
	char buf[8192] = {'\0'};
	gzFile gf;
	size_t l;
	size_t l2;
	unsigned char *str;

	// workaround for German/UK/Australian CD's
	if (!(CDType & CD_EXPANSION) && (CDType & (CD_GERMAN | CD_UK | CD_RUSSIAN))) {
		--txte;
	}

	// workaround for MAC expansion CD
	if ((CDType & CD_MAC) && txte >= 99) {
		txte += 6;
	}

	txtp = ExtractEntry(ArchiveOffsets[txte], &l);

    sprintf(buf, "%s/%s/%s.txt.gz", Dir.c_str(), TEXT_PATH, file);
	CheckPath(buf);
	gf = gzopen(buf, "wb9");
	if (!gf) {
		perror("");
		printf("Can't open %s\n", buf);
		error("Memory error", "Could not allocate enough memory to read archive.");
	}
	str = ConvertString(txtp + ofs, l - ofs);
	l2 = strlen((char *)str) + 1;

	if (l2 != (size_t)gzwrite(gf, str, l2)) {
		printf("Can't write %d bytes\n", (int)l2);
		fflush(stdout);
	}

	free(txtp);
	free(str);

	gzclose(gf);
	return 0;
}

/**
**  Convert text to my format.
*/
int SetupNames(const char *file __attribute__((unused)), int txte __attribute__((unused)))
{
    unsigned char *txtp;
    const unsigned short *mp;
	size_t l;
	unsigned u;
	unsigned n;

	//txtp = ExtractEntry(ArchiveOffsets[txte], &l);
	txtp = Names;
	l = sizeof(Names);
    mp = (const unsigned short *)txtp;

	n = ConvertLE16(mp[0]);
	for (u = 1; u < n; ++u) {
        //		printf("%d %x ", u, ConvertLE16(mp[u]));
        //		printf("%s\n", txtp + ConvertLE16(mp[u]));
		if (u < sizeof(UnitNames) / sizeof(*UnitNames)) {
#ifdef WIN32
            UnitNames[u] = _strdup((char *)txtp + ConvertLE16(mp[u]));
#else
            UnitNames[u] = strdup((char *)txtp + ConvertLE16(mp[u]));
#endif
			UnitNamesLast = u;
		}
	}

	if (txtp != Names) {
		free(txtp);
	}
	return 0;
}

/**
**  Parse string.
*/
char *ParseString(const char *input)
{
	static char buf[8192] = {'\0'};
    const char *sp;
    char *strsp;
    char *dp;
    char *tp;
	int i;
	int f;

    //	printf("%s -> ", input);

	for (sp = input, dp = buf; *sp;) {
		if (*sp == '%') {
			f = 0;
			if (*++sp == '-') {
				f = 1;
				++sp;
			}
			i = strtol(sp, &strsp, 0);
			sp = strsp;
			tp = UnitNames[i];
			if (f) {
				tp = strchr(tp, ' ') + 1;
			}
			while (*tp) {  // make them readabler
				if (*tp == '-') {
					*dp++ = '_';
					++tp;
				} else if (*tp == ' ') {
					*dp++ = '_';
					++tp;
				} else {
					*dp++ = tolower(*tp++);
				}
			}
			continue;
		}
		*dp++ = *sp++;
	}
	*dp = '\0';

    //	printf("%s\n", buf);
	return buf;
}

//----------------------------------------------------------------------------
//  Import the campaigns
//----------------------------------------------------------------------------

/**
**  FIXME: docu
*/
int CampaignsCreate(const char *file __attribute__((unused)), int txte, int ofs)
{
    unsigned char *objectives;
	char buf[8192] = {'\0'};
    unsigned char *CampaignData[2][26][10];
    unsigned char *current;
    unsigned char *next;
    unsigned char *nextobj;
    unsigned char *currentobj;
    FILE *outlevel;
	size_t l;
	int levelno;
	int noobjs;
	int race;
	int expansion;

	// Campaign data is in different spots for different CD's
	if (CDType & CD_EXPANSION) {
		expansion = 1;
		ofs = 236;
		txte = 54;
	} else {
		expansion = 0;
		// 53 for UK and German CD, else 54
		if (CDType & (CD_UK | CD_GERMAN | CD_RUSSIAN)) {
			txte = 53;
		} else {
			txte = 54;
		}
		// 172 for Spanish CD, 140 for anything else
		if (CDType & CD_SPANISH) {
			ofs = 172;
		} else {
			ofs = 140;
		}
	}

	objectives = ExtractEntry(ArchiveOffsets[txte], &l);
	if (!objectives) {
		printf("Objectives allocation failed\n");
		error("Memory error", "Could not allocate enough memory to read archive.");
	}
	objectives = (unsigned char *)realloc(objectives, l + 1);
	if (!objectives) {
		printf("Objectives allocation failed\n");
		error("Memory error", "Could not allocate enough memory to read archive.");
	}
	objectives[l] = '\0';

	//Now Search from start of objective data
	levelno = 0;
	race = 0;

	//Extract all the values for objectives
	if (expansion) {
		expansion = 52;
	} else {
		expansion = 28;
	}
	current = objectives + ofs;
	for (l = 0; l < (size_t)expansion; ++l) {
        next = current + strlen((char *)current) + 1;

		noobjs = 1;  // Number of objectives is zero.
		currentobj = current;
        while ((nextobj = (unsigned char *)strchr((char *)currentobj, '\n')) != NULL) {
			*nextobj = '\0';
			++nextobj;
			CampaignData[race][levelno][noobjs] = currentobj;
			currentobj = nextobj;
			++noobjs;
		}
		// Get the final one.
		CampaignData[race][levelno][noobjs] = currentobj;
		for (++noobjs; noobjs < 10; ++noobjs) {
			CampaignData[race][levelno][noobjs] = NULL;
		}
		current = next;
		if (race == 0) {
			race = 1;
		} else if (race == 1) {
			race = 0;
			++levelno;
		};
	}

	// Extract the Level titles now.
	race = 0;
	levelno = 0;
	// Find the start of the Levels
	while (current[0] && current[0] != 'I' && current[1] != '.') {
        current = current + strlen((char *)current) + 1;
	}
	for (l = 0; l < (size_t)expansion; ++l) {
        next = current + strlen((char *)current) + 1;
		CampaignData[race][levelno][0] = current;
		current = next;
		if (race == 0) {
			race = 1;
		} else {
			if (race == 1) {
				race = 0;
				++levelno;
			}
		}
	}

	for (levelno = 0; levelno < expansion / 2; ++levelno) {
		for (race = 0; race < 2; ++race) {
			//Open Relevant file, to write stuff too.
            sprintf(buf, "%s/%s/%s_c2.sms", Dir.c_str(), TEXT_PATH,
                    Todo[2 * levelno + 1 + race + 5].File.c_str());
			CheckPath(buf);
			if (!(outlevel = fopen(buf, "wb"))) {
				printf("Cannot Write File (Skipping Level: %s)\n", buf);
				fflush(stdout);
				continue;
			}
			unsigned char *str = ConvertString(CampaignData[race][levelno][0], 0);
			sprintf(buf, "title = \"%s\"\n", str);
			fputs(buf, outlevel);
			free(str);
			fputs("objectives = {", outlevel);
			for (noobjs = 1; noobjs < 10; ++noobjs) {
				if (CampaignData[race][levelno][noobjs] != NULL) {
					unsigned char *str = ConvertString(CampaignData[race][levelno][noobjs], 0);
					sprintf(buf, "%s\"%s\"", (noobjs > 1 ? "," : ""), str);
					fputs(buf, outlevel);
					free(str);
				}
			}
			fputs("}\n", outlevel);
			// Close levels and move on.
			fclose(outlevel);
		}
	}

	free(objectives);
	return 0;
}

//----------------------------------------------------------------------------
//  Fix SPK translation
//----------------------------------------------------------------------------

void FixTranslation(const char *translation)
{
	struct stat st;

	if (!stat(translation, &st)) {
		FILE *iFile = fopen(translation, "rb");
		if (iFile == NULL) {
			return;
		}
		unsigned char *buf = new unsigned char[st.st_size];
		unsigned char *p = buf;
		while (!feof(iFile)) {
			*p++ = fgetc(iFile);
		}
		fclose(iFile);

		FILE *oFile = fopen(translation, "wb");
		if (oFile == NULL) {
			return;
		}
		p = buf;
		for (long i = 0; i < st.st_size; ++i, ++p) {
			unsigned char c = *p;
			if (c >= 0x80) {
				if (c >= 0xE0 && c < 0xF0) {
					c -= 0x30;
				}
				fputc(0xC2, oFile);
				fputc(c, oFile);
			} else {
				fputc(c, oFile);
			}
		}
	}
}

#define OUR_EXPANSION_SUBDIR "wargus.exp.data"

void copyArchive(const char *partialPath)
{
	FILE *source, *target;
	char srcname[PATH_MAX] = {'\0'};
	char tgtname[PATH_MAX] = {'\0'};

    strcpy(tgtname, Dir.c_str());
	strcat(tgtname, SLASH);
	if (CDType & CD_EXPANSION && !(CDType & CD_BNE)) {
		// expansion CD, copy the archive in a subdir
		strcat(tgtname, OUR_EXPANSION_SUBDIR);
		strcat(tgtname, SLASH);
	}
	strcat(tgtname, partialPath);
#ifdef WIN32
	for (unsigned int i = 0; i < strlen(tgtname); i++) {
		if (tgtname[i] == '/') {
			tgtname[i] = '\\';
		}
	}
#endif

	strcpy(srcname, ArchiveDir);
	strcat(srcname, SLASH);
	strcat(srcname, partialPath);

	struct stat st;
	if (stat(tgtname, &st) == 0) {
		return;
	}

	if (!strcmp(srcname, tgtname)) {
		return;
	}


	source = fopen(srcname, "rb");
	if (source == NULL) {
		fprintf(stderr, "Cannot copy %s...\n", srcname);
		exit(-1);
	}

#ifdef WIN32
	char *tgtname_copy = _strdup(tgtname);
#else
	char *tgtname_copy = strdup(tgtname);
#endif
	parentdir(tgtname_copy);
	mkdir_p(tgtname_copy);
	target = fopen(tgtname, "wb");
	if (target == NULL) {
		fclose(source);
		fprintf(stderr, "Cannot open %s for writing.\n", tgtname);
		exit(-1);
	}

	char buf[4096];
	int c = 0;
	while (c = fread(buf, sizeof(char), 4096, source)) {
		fwrite(buf, sizeof(char), c, target);
	}
	printf("Copied %s->%s\n", srcname, tgtname);

	fclose(source);
	fclose(target);
}

//----------------------------------------------------------------------------
//  Main loop
//----------------------------------------------------------------------------

/**
**  Display the usage.
*/
void Usage(const char *name)
{
	printf("%s\n\
Usage: %s [-e|-n] [-v] [-r] [-V] [-h|--help] archive-directory [destination-directory]\n\
\t-e\tThe archive is expansion compatible (default: autodetect)\n\
\t-n\tThe archive is not expansion compatible (default: autodetect)\n\
\t-v\tExtract and convert videos\n\
\t-r\tRip sound tracks from CD-ROM (needs original CD, no image/emulation)\n\
\t-V\tShow version\n\
\t-h\tShow usage (this text)\n\
archive-directory\tDirectory which includes the archives maindat.war or the battle.net tomes...\n\
destination-directory\tDirectory where the extracted files are placed.\n"
           , NameLine, name);
	fflush(stdout);
}

int ExtractImplicitExpansion(char **argv, int a)
{
	printf("Extracting from expansion subdir\n");
	struct stat st;
	char buf[PATH_MAX] = {'\0'};
	// detect if the expansion directory is next to the data directory
	if (strstr(ArchiveDir, OUR_EXPANSION_SUBDIR)) {
		// we're already trying to extract from our expansion subdir, don't recurse
		return -1;
	}
	sprintf(buf, "%s/%s", ArchiveDir, OUR_EXPANSION_SUBDIR);
	if (!stat(buf, &st)) {
		// expansion subdir available, extract from it
		char ExpansionArchiveDir[PATH_MAX] = {'\0'};
		strcpy(ExpansionArchiveDir, ArchiveDir);
		strcat(ExpansionArchiveDir, "/");
		strcat(ExpansionArchiveDir, OUR_EXPANSION_SUBDIR);
		if (strcmp(argv[a], ArchiveDir)) {
			fprintf(stderr, "assertion error: expected argv[a] (%s) to point to ArchiveDir (%s)\n", argv[a], ArchiveDir);
			exit(-1);
		}
		argv[a] = ExpansionArchiveDir;
#ifdef WIN32
		int execresult = _execv(argv[0], argv);
#else
		int execresult = execv(argv[0], argv);
#endif
		if (execresult) {
			fprintf(stderr, "an error occurred trying to extract from the expansion archives\n");
			exit(-1);
		}
	}
	return -1;
}

#ifdef WIN32
#include <tchar.h>
#include <io.h>

#define BUFSIZE 4096
#define VARNAME TEXT("APPDATA")
#define GAMEDIR TEXT("\\Stratagus")
#define LOGFILE TEXT("\\wartool.txt")

static int stdoutTeeFds[3] = {0, 0, 0};
static int stderrTeeFds[3] = {0, 0, 0};
static int stdoutPipes[2] = {0, 0};
static int stderrPipes[2] = {0, 0};
static HANDLE threadStdout;
static HANDLE threadStderr;

DWORD WINAPI ThreadFunc(void *data)
{
    int *fds = (int *) data;
	int readPipe = fds[0];
	int oldStd = fds[1];
	int logfile = fds[2];
	bool eof = false;

	while (!eof) {
		char c[256] = {'\0'};
		int cnt = 0;
		if ((cnt = _read(readPipe, c, 256)) > 0) {
			_write(oldStd, c, cnt);
			_lseek(logfile, 0, SEEK_END);
			_write(logfile, c, cnt);
		} else {
			eof = true;
		}
	}
	_commit(logfile);
	return 0;
}

void teeStdout()
{
	int stdDuplicates[2] = {0, 0};
	stdDuplicates[0] = _dup(1);
	stdDuplicates[1] = _dup(2);
	if (_pipe(stdoutPipes, 256, _O_BINARY) != 0) {
		fprintf(stderr, "Pipe error!\n");
		exit(1);
	}
	if (_pipe(stderrPipes, 256, _O_BINARY) != 0) {
		fprintf(stderr, "Pipe error!\n");
		exit(1);
	}

    char *stdoutpath = GetExtractionLogPath("Wargus", (char *)Dir);
	int logfilefd = _open(stdoutpath, _O_WRONLY | _O_CREAT | _O_BINARY | _O_TRUNC, _S_IWRITE);

    // make stdout/stderr write into the write ends of the pipes
	_dup2(stdoutPipes[1], 1);
	_dup2(stderrPipes[1], 2);
	// start a thread to read from the read ends of those pipes, and write to the old stdout/stderr and to a logfile

	stdoutTeeFds[0] = stdoutPipes[0];
	stdoutTeeFds[1] = stdDuplicates[0];
	stdoutTeeFds[2] = logfilefd;
	threadStdout = CreateThread(NULL, 0, ThreadFunc, stdoutTeeFds, 0, NULL);
	if (!threadStdout) {
		fprintf(stderr, "Thread error!\n");
		exit(1);
	}

	stderrTeeFds[0] = stderrPipes[0];
	stderrTeeFds[1] = stdDuplicates[1];
	stderrTeeFds[2] = logfilefd;
	threadStderr = CreateThread(NULL, 0, ThreadFunc, stderrTeeFds, 0, NULL);
	if (!threadStderr) {
		fprintf(stderr, "Thread error!\n");
		exit(1);
	}
}

void endTee()
{
	// redirect stdout back to the original
	_dup2(stdoutTeeFds[1], 1);
	// close write end of pipe
	_close(stdoutPipes[1]);
	// redirect stderr back to the original
	_dup2(stderrTeeFds[1], 2);
	// close write end of pipe
	_close(stderrPipes[1]);
	// join threads
	WaitForSingleObject(threadStdout, INFINITE);
	WaitForSingleObject(threadStderr, INFINITE);

	_close(stdoutPipes[0]);
	_close(stderrPipes[0]);

	CloseHandle(threadStdout);
	CloseHandle(threadStderr);
}
#else
void teeStdout()
{
}
void endTee()
{
}
#endif

/**
**		Main
*/
#undef main
int main(int argc, char **argv)
{
	unsigned u;
	char buf[8192] = {'\0'};
	struct stat st;
	int expansion_cd = 0;
	int video = 0;
	int rip = 0;
	int a = 1;
	char filename[8192] = {'\0'};
    FILE *f;

    if (argc == 1) {
		Usage(argv[0]);
		return 1;
	}

	while (argc >= 2) {
		if (!strcmp(argv[a], "-v")) {
			video = 1;
			++a;
			--argc;
			continue;
		}
		if (!strcmp(argv[a], "-r")) {
			rip = 1;
			++a;
			--argc;
			continue;
		}
		if (!strcmp(argv[a], "-e")) {
			expansion_cd = 1;
			++a;
			--argc;
			continue;
		}
		if (!strcmp(argv[a], "-n")) {
			expansion_cd = -1;
			++a;
			--argc;
			continue;
		}
		if (!strcmp(argv[a], "-V")) {
			printf(VERSION "\n");
			++a;
			--argc;
			exit(0);
		}
		if (!strcmp(argv[a], "-h") || !strcmp(argv[a], "--help")) {
			Usage(argv[0]);
			++a;
			--argc;
			exit(0);
		}
		break;
	}


	ArchiveDir = argv[a];

	// if the user selected the install.exe from the DOS CD, be gratious
    char *extraPath = (char *)calloc(sizeof(char), strlen(ArchiveDir) + strlen("/data/rezdat.war") + 1);
	sprintf(extraPath, "%s/data/rezdat.war", ArchiveDir);
	if (stat(extraPath, &st) == 0) {
		sprintf(extraPath, "%s/data", ArchiveDir);
		ArchiveDir = extraPath;
	} else {
		sprintf(extraPath, "%s/DATA/REZDAT.WAR", ArchiveDir);
		if (stat(extraPath, &st) == 0) {
			sprintf(extraPath, "%s/DATA", ArchiveDir);
			ArchiveDir = extraPath;
		}
	}

	if (argc == 3) {
        Dir = argv[a + 1];
	} else {
		Dir = "data";
	}
	teeStdout();

    sprintf(buf, "%s/extracted", Dir.c_str());
	f = fopen(buf, "r");
	if (f) {
		char version[20];
		int len = 0;
        if (fgets(version, 20, f)) {
			len = 1;
        }
        fclose(f);
		if (len != 0 && strcmp(version, VERSION) == 0) {
            printf("Note: Data is already extracted in Dir \"%s\" with this version of wartool\n", Dir.c_str());
			fflush(stdout);
		}
	}

	// Detect if CD is Mac/Dos, Expansion/Original/BNE, and language
	sprintf(buf, "%s/support/tomes/tome.1", ArchiveDir);
	if (!stat(buf, &st)) {
		sprintf(filename, "%s/support/tomes/tome.4", ArchiveDir);
		printf("Detected BNE CD\n");
		fflush(stdout);
		CDType |= CD_BNE | CD_EXPANSION | CD_US;
	} else if (sprintf(buf, "%s/Support/TOMES/TOME.1", ArchiveDir) && !stat(buf, &st)) {
		sprintf(filename, "%s/Support/TOMES/TOME.4", ArchiveDir);
		printf("Detected BNE CD Captialized\n");
		fflush(stdout);
		CDType |= CD_BNE | CD_BNE_CAPS | CD_EXPANSION | CD_US;
	} else if (sprintf(buf, "%s/SUPPORT/TOMES/TOME.1", ArchiveDir) && !stat(buf, &st)) {
		sprintf(filename, "%s/SUPPORT/TOMES/TOME.4", ArchiveDir);
		printf("Detected BNE CD Uppercase\n");
		fflush(stdout);
		CDType |= CD_BNE | CD_BNE_UPPER | CD_EXPANSION | CD_US;
	} else {
		sprintf(buf, "%s/rezdat.war", ArchiveDir);
		sprintf(filename, "%s/strdat.war", ArchiveDir);
		if (stat(buf, &st)) {
			sprintf(buf, "%s/REZDAT.WAR", ArchiveDir);
			sprintf(filename, "%s/STRDAT.WAR", ArchiveDir);
			CDType |= CD_UPPER;
		}
		if (stat(buf, &st)) {
			CDType |= CD_MAC | CD_US;
			sprintf(buf, "%s/War Resources", ArchiveDir);
			if (stat(buf, &st)) {
				if (ExtractImplicitExpansion(argv, a)) {
					// try extracting from implicitly copied expansion data from
					// a previous expansion-only extraction
					printf("Could not find Warcraft 2 Data\n");
					error("Data not found", "Could not find Warcraft 2 data in folder. "
						  "Make sure you have selected the DATA directory of the DOS version, "
						  "or the root of the Battle.net CD.");
				}
			}
			if (expansion_cd == -1 || (expansion_cd != 1 && st.st_size != 2876978)) {
				printf("Detected original MAC CD\n");
				fflush(stdout);
			} else {
				printf("Detected expansion MAC CD\n");
				fflush(stdout);
				CDType |= CD_EXPANSION;
			}
		} else {
			if (st.st_size != 2811086) {
				expansion_cd = 0;
				stat(filename, &st);
				switch (st.st_size) {
					case 51550:
						printf("Detected US original DOS CD\n");
						fflush(stdout);
						CDType |= CD_US;
						break;
					case 53874:
						printf("Detected Italian original DOS CD\n");
						fflush(stdout);
						CDType |= CD_ITALIAN;
						break;
					case 55014:
						printf("Detected Spanish original DOS CD\n");
						fflush(stdout);
						CDType |= CD_SPANISH;
						break;
					case 55724:
						printf("Detected German original DOS CD\n");
						fflush(stdout);
						CDType |= CD_GERMAN;
						break;
					case 51451:
						printf("Detected UK/Australian original DOS CD\n");
						fflush(stdout);
						CDType |= CD_UK;
						break;
					case 52883:
						printf("Detected Portuguese original DOS CD\n");
						fflush(stdout);
						CDType |= CD_PORTUGUESE;
						break;
					case 55079:
						printf("Detected French original DOS CD\n");
						fflush(stdout);
						CDType |= CD_FRENCH;
						break;
					case 52152:
						printf("Detected Russian SPK DOS CD\n");
						fflush(stdout);
						CDType |= CD_RUSSIAN;
						break;

					default:
						printf("Could not detect CD version:\n");
						printf("Defaulting to German original DOS CD\n");
						fflush(stdout);
						CDType |= CD_GERMAN;
						break;
				}
			} else {
				stat(filename, &st);
				switch (st.st_size) {
					case 74422:
						printf("Detected Russian expansion DOS CD\n");
						fflush(stdout);
						CDType |= CD_EXPANSION | CD_RUSSIAN;
						break;
					default:
						printf("Detected expansion DOS CD\n");
						fflush(stdout);
						CDType |= CD_EXPANSION | CD_US;
						break;
				}
			}
		}
	}

	if (expansion_cd == -1 || (expansion_cd != 1 && !(CDType & CD_EXPANSION))) {
		expansion_cd = 0;
	} else {
		expansion_cd = 1;
	}
	if (CDType & CD_BNE) {
#ifndef USE_STORMLIB
		printf("Please compile wartool with StormLib library to extract the data.\n");
		error("Archive version error", "The Battle.net edition is not supported by this version of "
			  "the extractor tool. Please compile wartool with StormLib.");
#endif
	}

    printf("Extract from \"%s\" to \"%s\"\n", ArchiveDir, Dir.c_str());
	printf("Please be patient, the data may take a couple of minutes to extract...\n");
	fflush(stdout);

	for (u = 0; u < sizeof(Todo) / sizeof(*Todo); ++u) {
		if (CDType & CD_MAC) {
            std::string filename = Todo[u].File;
			ConvertToMac(filename);
			Todo[u].File = filename;
		}
		// Should only be on the expansion cd
#ifdef DEBUG
		// printf("%s:\n", ParseString(Todo[u].File));
		fflush(stdout);
#endif
        if (!expansion_cd && (Todo[u].Version & 2)) {
			continue;
		}
		// Extract dummy expansion files
		if (expansion_cd && Todo[u].Version == 3) {
			continue;
		}
		// Only present in original DOS versions
		if ((CDType & CD_BNE) && (Todo[u].Version & 4)) {
			continue;
		}
		// Only present in BNE version
		if (!(CDType & CD_BNE) && (Todo[u].Version & 8)) {
			continue;
		}
		switch (Todo[u].Type) {
			case F:
				if (CDType & CD_BNE) {
					for (int i = 0; i < sizeof(BNEReplaceTable) / sizeof(*BNEReplaceTable) ; i += 2) {
                        if (!strcmp(BNEReplaceTable[i], Todo[u].File.c_str())) {
                            Todo[u].File = BNEReplaceTable[i + 1];
							if (CDType & CD_BNE_CAPS) {
								Todo[u].File = BNEReplaceTableCaps[i + 1];
							} else if (CDType & CD_BNE_UPPER) {
                                strcpy(filename, Todo[u].File.c_str());
								while (filename[i]) {
									filename[i] = toupper(filename[i]);
									++i;
								}
								Todo[u].File = filename;
							}
							break;
						}
					}
				} else if (CDType & CD_UPPER) {
					int i = 0;
                    strcpy(filename, Todo[u].File.c_str());
					while (filename[i]) {
						filename[i] = toupper(filename[i]);
						++i;
					}
					Todo[u].File = filename;
				}
                sprintf(buf, "%s/%s", ArchiveDir, Todo[u].File.c_str());
				printf("Archive \"%s\"\n", buf);
				fflush(stdout);
				if (ArchiveBuffer) {
					CloseArchive();
				}
				OpenArchive(buf, Todo[u].Arg1);
                copyArchive(Todo[u].File.c_str());
				break;
			case Q:
				if (!(CDType & CD_BNE)) {
					printf("Error - not a BNE disk\n");
					error("Archive version error", "This version of the CD is not supported");
				}
#ifdef USE_STORMLIB
				char mpqfile[8192];
				char extract[8192];
				memset(mpqfile, 0, 8192);
				memset(extract, 0, 8192);
				if (Todo[u].Arg1 == 1) { // local archive
                    sprintf(mpqfile, "%s/%s", Dir.c_str(), Todo[u].MPQFile);
					if (Todo[u].ArcFile == NULL) {
						// delete
						printf("deleting temporary MPQ file \"%s\"\n", mpqfile);
#ifdef WIN32
						_unlink(mpqfile);
#else
						unlink(mpqfile);
#endif
						continue;
					}
					printf("%s from MPQ file \"%s\"\n", Todo[u].ArcFile, mpqfile);
				} else {
#ifdef WIN32
                    char *filename = _strdup(Todo[u].MPQFile);
#else
                    char *filename = strdup(Todo[u].MPQFile);
#endif
					// initially all lowercase
					for (unsigned int i = 0; i < strlen(filename); i++) {
						filename[i] = tolower(filename[i]);
					}
					// let's see....
					sprintf(mpqfile, "%s/%s", ArchiveDir, filename);
					if (stat(mpqfile, &st)) {
						// try with initial uppercase
						filename[0] = toupper(filename[0]);
						sprintf(mpqfile, "%s/%s", ArchiveDir, filename);
					}
					if (stat(mpqfile, &st)) {
						// try all uppercase
						for (unsigned int i = 0; i < strlen(filename); i++) {
							filename[i] = toupper(filename[i]);
						}
						sprintf(mpqfile, "%s/%s", ArchiveDir, filename);
					}
					if (stat(mpqfile, &st)) {
						// try with alternative extension (mpq/exe)
						free(filename);
#ifdef WIN32
						filename = _strdup(Todo[u].MPQFile);
#else
						filename = strdup(Todo[u].MPQFile);
#endif
						// initially all lowercase
						for (unsigned int i = 0; i < strlen(filename); i++) {
							filename[i] = tolower(filename[i]);
						}
						// swap extension
						if (strstr(filename, ".exe")) {
							strncpy(strstr(filename, ".exe"), ".mpq", 4);
						} else if (strstr(filename, ".mpq")) {
							strncpy(strstr(filename, ".mpq"), ".exe", 4);
						}
						sprintf(mpqfile, "%s/%s", ArchiveDir, filename);
					}
					if (stat(mpqfile, &st)) {
						// try with initial uppercase
						filename[0] = toupper(filename[0]);
						sprintf(mpqfile, "%s/%s", ArchiveDir, filename);
					}
					if (stat(mpqfile, &st)) {
						// try all uppercase
						for (unsigned int i = 0; i < strlen(filename); i++) {
							filename[i] = toupper(filename[i]);
						}
						sprintf(mpqfile, "%s/%s", ArchiveDir, filename);
					}
					if (stat(mpqfile, &st)) {
						sprintf(mpqfile, "%s/%s not found!", ArchiveDir, Todo[u].MPQFile);
						error(mpqfile, "I also tried different cases and tried both .mpq and .exe extensions\n");
					}
                    printf("%s from MPQ file \"%s\"\n", Todo[u].File.c_str(), mpqfile);
					// strip ArchiveDir and slash before copying
#ifdef WIN32
                    char *copyfile = _strdup(mpqfile);
#else
                    char *copyfile = strdup(mpqfile);
#endif
					copyfile = copyfile + strlen(ArchiveDir);
					copyArchive(copyfile);
				}
                sprintf(extract, "%s/%s", Dir.c_str(), Todo[u].File.c_str());
				if (Todo[u].Arg2 == 1) { // compress
					sprintf(extract, "%s.gz", extract);
				}
				if (Todo[u].Arg2 == 2) { // video file
					sprintf(extract, "%s.smk", extract);
				}
				if (Todo[u].Arg2 == 8 && !rip) { // wav audio
					continue;
				}
                if (ExtractMPQFile(mpqfile, (char *)Todo[u].ArcFile, extract, Todo[u].Arg2 == 1)) {
                    printf("Failed to extract \"%s\"\n", (char *)Todo[u].ArcFile);
				}
				if (Todo[u].Arg2 == 2) { // convert videos
					if (video) {
                        ConvertVideo(Todo[u].File.c_str(), Todo[u].Arg1, true);
					}
				}
				if (Todo[u].Arg2 == 4) { // convert videos
                    ConvertPud(Todo[u].File.c_str(), 0, true);
				}
#endif
				break;
			case R:
                ConvertRgb(Todo[u].File.c_str(), Todo[u].Arg1);
				break;
			case T:
                ConvertTileset(Todo[u].File.c_str(), Todo[u].Arg1, Todo[u].Arg2,
                               Todo[u].Arg3, Todo[u].Arg4);
				break;
			case G:
                ConvertGfx(ParseString(Todo[u].File.c_str()), Todo[u].Arg1, Todo[u].Arg2,
                           Todo[u].Arg3, Todo[u].Arg4);
				break;
			case U:
                ConvertGfu(Todo[u].File.c_str(), Todo[u].Arg1, Todo[u].Arg2);
				break;
			case D:
                ConvertGroupedGfu(Todo[u].File.c_str(), Todo[u].Arg1, Todo[u].Arg2,
                                  Todo[u].Arg3);
				break;
			case P:
				ConvertPud(Todo[u].File, Todo[u].Arg1);
				break;
			case N:
                ConvertFont(Todo[u].File.c_str(), 2, Todo[u].Arg1);
				break;
			case I:
                ConvertImage(Todo[u].File.c_str(), Todo[u].Arg1, Todo[u].Arg2,
                             Todo[u].Arg3, Todo[u].Arg4);
				break;
			case C:
                ConvertCursor(Todo[u].File.c_str(), Todo[u].Arg1, Todo[u].Arg2);
				break;
			case M:
				ConvertXmi(Todo[u].File, Todo[u].Arg1);
				break;
			case W:
				ConvertWav(Todo[u].File, Todo[u].Arg1);
				break;
			case X:
                ConvertText(Todo[u].File.c_str(), Todo[u].Arg1, Todo[u].Arg2);
				break;
			case S:
                SetupNames(Todo[u].File.c_str(), Todo[u].Arg1);
				break;
			case V:
				if (video) {
                    ConvertVideo(Todo[u].File.c_str(), Todo[u].Arg1);
				}
				break;
			case L:
                CampaignsCreate(Todo[u].File.c_str(), Todo[u].Arg1, Todo[u].Arg2);
				break;
			default:
				break;
		}
	}

	ConvertFilePuds(OriginalPuds);
	ConvertFilePuds(ExpansionPuds);

	CopyMusic();

	if (rip && !(CDType & CD_BNE)) {
        sprintf(buf, "%s/%s/", Dir.c_str(), MUSIC_PATH);
		CheckPath(buf);
		rip = (RipMusic(expansion_cd, ArchiveDir, buf) == 0);
	}

	ConvertMusic();

	if (ArchiveBuffer) {
		CloseArchive();
	}
	if (Pal27) {
		free(Pal27);
	}

	while (UnitNamesLast > 0) {
		free(UnitNames[UnitNamesLast]);
		--UnitNamesLast;
	}

    sprintf(buf, "%s/scripts/wc2-config.lua", Dir.c_str());
	CheckPath(buf);
	f = fopen(buf, "w");

	if (!f) {
		perror("");
		printf("Can't open %s\n", buf);
		error("Memory error", "Could not allocate enough memory to read archive.");
	}

	fprintf(f, "wargus.tales = false\n");
	if (expansion_cd) {
		fprintf(f, "wargus.expansion = true\n");
	} else {
		fprintf(f, "wargus.expansion = false\n");
	}
	if (rip) {
		fprintf(f, "wargus.music_extension = \".ogg\"\n");
	} else {
		fprintf(f, "wargus.music_extension = \".mid\"\n");
	}
	if (CDType & CD_BNE) {
		fprintf(f, "wargus.bne = true\n");
	} else {
		fprintf(f, "wargus.bne = false\n");
	}
	fprintf(f, "wargus.game_font_width = %d\n", game_font_width);
	fclose(f);

    sprintf(buf, "%s/extracted", Dir.c_str());
	f = fopen(buf, "w");

	if (!f) {
		perror("");
		printf("Can't open %s\n", buf);
		error("Memory error", "Could not allocate enough memory to read archive.");
	}

	fputs(VERSION, f);
	fclose(f);

    sprintf(buf, "%s/scripts/translate/ru_RU.po", Dir.c_str());
	FixTranslation(buf);
    sprintf(buf, "%s/scripts/translate/stratagus-ru.po", Dir.c_str());
	FixTranslation(buf);

    sprintf(buf, "%s/%s", Dir.c_str(), REEXTRACT_MARKER_FILE);
	f = fopen(buf, "w");
	fputs("data copied for re-extraction", f);
	fclose(f);

	printf("Done.\n");

	ExtractImplicitExpansion(argv, a);

	endTee();

	return 0;
}

//@}
