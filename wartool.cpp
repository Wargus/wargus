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

#include "wartool.h"
#include "wargus.h"
#include <stratagus-gameutils.h>

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

#include "PngIO.hpp"
#include <limits.h>
#include <stdlib.h>

#include "endian.h"
#include "pud.h"
#include "rip_music.h"
#include "xmi2mid.h"

#ifndef __GNUC__
#define __attribute__(args) // Does nothing for non GNU CC
#endif

#ifndef O_BINARY
#define O_BINARY 0
#endif

#ifndef WIN32
#define _T(x) x
#else
#define _T(x) L ## x
#endif

#include "Image.hpp"
#include <algorithm>
#include <array>
#include <fstream>
#include <iostream>
#include <string>
#include <vector>

void error(const std::string &first, const std::string &second)
{
    return error(first.c_str(), second.c_str());
}

void error(const char *first, const wchar_t *second)
{
    auto temp_string = tinyfd_utf16to8(second);
    error(first, temp_string);
    free(temp_string);
}

void error(const std::wstring &first, const wchar_t *second)
{
    auto temp_string = tinyfd_utf16to8(second);
    auto temp2 = tinyfd_utf16to8(first.c_str());
    error(temp2, temp_string);
    free(temp_string);
    free(temp2);
}
void error(const std::wstring &first, const char *second)
{
    auto temp_string = tinyfd_utf16to8(first.c_str());
    error(temp_string, second);
    free(temp_string);
}

/**
**		Destination directory of the graphics
*/
// FIXME: Had to remove const on Dir since it is assigned to in main.
std::filesystem::path Dir;

using byte = unsigned char; // maybe change to std::byte later.

std::vector<unsigned char> read_file_to_vector(const fs::path &file)
{
    std::vector<unsigned char> out{};
    std::error_code ec{};
    size_t filesize = fs::file_size(file, ec);
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

//----------------------------------------------------------------------------

/**
**  Palette N27, for credits cursor
*/
static std::shared_ptr<unsigned char[]> Pal27;

/**
**  Original archive buffer.
*/
static std::unique_ptr<unsigned char[]> ArchiveBuffer;

/**
**  Offsets for each entry into original archive buffer.
*/
static std::vector<unsigned char *> ArchiveOffsets;

/**
**  Fake empty entry
*/
static unsigned int EmptyEntry[] = {1, 1, 1};

static fs::path ArchiveDir;

/**
**  What CD Type is it?
*/
static int CDType;

// Width of game font
static int game_font_width;

/**
**  File names.
*/
static std::vector<std::string> UnitNames;
// static char *UnitNames[110];

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
        std::cerr << "Error in CheckPath, could not create directories!\n"
                  << error_code.message() << std::endl;
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
int SavePNG(const fs::path &name, Image &image, unsigned char *pal,
            int transparent)
{
    PNGWriter writer{};
    writer.write(name, image, pal, transparent);
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
int SavePNG(const fs::path &name, Image &image, int x, int y, int w, size_t h,
            int pitch, unsigned char *pal, int transparent)
{
    PNGWriter writer{};
    writer.write(name, image, x, y, w, h, pitch, pal, transparent);
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
int OpenArchive(const fs::path &file, int type)
{
    unsigned char *cp;
    int entries;
    int i;

    //
    //  Open the archive file
    //
    std::ifstream f{file, std::ios::binary};
    if (!f.is_open()) {
        error("Can't open file", file.c_str());
        return 1;
    }
    std::error_code ec{};
    size_t file_size = fs::file_size(file, ec);
    if (ec) {
        error("Can't determine file size", file.c_str());
        return 1;
    }

    //
    //  Read in the archive
    //
    std::unique_ptr<unsigned char[]> buf =
        std::make_unique<unsigned char[]>(file_size);
    if (!buf) {
        std::cout << "Can't malloc " << file_size << std::endl;
        error("Memory error", "Could not allocate enough memory to read archive.");
        return 1;
    }
    f.read(reinterpret_cast<char *>(buf.get()), file_size);
    if (f.fail()) {
        std::cout << "Can't read " << file_size << std::endl;
        error("Memory error", "Could not read archive into RAM.");
        return 1;
    }
    f.close();

    cp = buf.get();
    i = FetchLE32(cp);
    if (i != 0x19) {
        std::cout << "Wrong magic " << i << ", expected " << 0x00000019
                  << std::endl;
        error("Archive version error", "This version of the data is not supported");
    }
    entries = FetchLE16(cp);
    i = FetchLE16(cp);
    if (i != type) {
        std::cout << "Wrong type " << i << ", expected " << type << std::endl;
        error("Archive version error", "This version of the data is not supported");
    }

    //
    //  Read offsets.
    //
    std::vector<unsigned char *> op;
    op.resize(entries + 1);

    for (i = 0; i < entries; ++i) {
        op[i] = buf.get() + FetchLE32(cp);
        // check if entry size is not bigger then archive size
        if (op[i] >= buf.get() + file_size - 4) {
            op[i] = (unsigned char *)&EmptyEntry;
            std::cout << "Ignore entry " << i << " in archive (invalid offset)"
                      << std::endl;
            std::flush(std::cout);
        } else {
            unsigned char *dp = op[i];
            size_t length = FetchLE32(dp);
            int flags = length >> 24;
            length &= 0x00FFFFFF;
            if (flags == 0x00 && op[i] + length >= buf.get() + file_size) {
                op[i] = (unsigned char *)&EmptyEntry;
                std::cout << "Ignore entry " << i
                          << " in archive (invalid uncompressed length)" << std::endl;
                std::flush(std::cout);
            }
        }
    }
    op[i] = buf.get() + file_size;

    ArchiveOffsets = std::move(op);
    ArchiveBuffer = std::move(buf);

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
std::unique_ptr<unsigned char[]> ExtractEntry(unsigned char *cp, size_t *lenp)
{
    unsigned char *dp;
    std::unique_ptr<unsigned char[]> dest;
    size_t uncompressed_length;
    int flags;

    uncompressed_length = FetchLE32(cp);
    flags = uncompressed_length >> 24;
    uncompressed_length &= 0x00FFFFFF;

    dest = std::make_unique<unsigned char[]>(uncompressed_length);

    dp = dest.get();
    if (!dest) {
        std::cout << "Can't malloc " << uncompressed_length << std::endl;
        error("Memory error", "Could not allocate enough memory to read archive.");
    }

    if (flags == 0x20) {
        unsigned char buf[8192] = {'\0'};
        unsigned char *ep;
        int bi;

        bi = 0;
        memset(buf, 0, sizeof(buf));
        ep = dp + uncompressed_length;

        while (dp < ep) {
            int i;
            int bflags;

            bflags = FetchByte(cp);
            for (i = 0; i < 8; ++i) {
                int j;
                int o;

                if (bflags & 1) {
                    j = FetchByte(cp);
                    *dp++ = j;
                    buf[bi++ & 0xFFF] = j;
                } else {
                    o = FetchLE16(cp);
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
        }
    } else if (flags == 0x00) {
        std::memcpy(dest.get(), cp, uncompressed_length);
    } else {
        std::cout << "Unknown flags " << flags << std::endl;
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
    ArchiveBuffer.reset();
    return 0;
}

#ifdef USE_STORMLIB
int ExtractMPQFile(const fs::path &szArchiveName, std::string szArchivedFile,
                   const fs::path &szFileName, bool compress)
{
    HANDLE hMpq = NULL;         // Open archive handle
    HANDLE hFile = NULL;        // Archived file handle
    gzFile gzfile = NULL;       // Compressed file handle
    int nError = ERROR_SUCCESS; // Result value

    // Open an archive, e.g. "d2music.mpq"
    if (nError == ERROR_SUCCESS) {

        if (!SFileOpenArchive(szArchiveName.c_str(), 0, STREAM_FLAG_READ_ONLY,
                              &hMpq)) {
            nError = GetLastError();
        }
    }

    // Open a file in the archive, e.g. "data\global\music\Act1\tristram.wav"
    if (nError == ERROR_SUCCESS) {
        if (!SFileOpenFileEx(hMpq, szArchivedFile.c_str(), 0, &hFile)) {
            nError = GetLastError();
        }
    }

    std::ofstream file;
    // Create the target file
    if (nError == ERROR_SUCCESS) {
        CheckPath(szFileName);
        if (compress) {
#ifndef WIN32
            gzfile = gzopen(szFileName.c_str(), "wb9");
#else
            gzfile = gzopen_w(szFileName.c_str(), "wb9");
#endif
        } else {
            file.open(szFileName, std::ios::binary);
        }
    }

    // Read the file from the archive
    if (nError == ERROR_SUCCESS) {
        char szBuffer[0x10000];
        DWORD dwBytes = 1;

        while (dwBytes > 0) {
            SFileReadFile(hFile, szBuffer, sizeof(szBuffer), &dwBytes, NULL);
            if (dwBytes > 0) {
                if (compress) {
                    gzwrite(gzfile, szBuffer, dwBytes);
                } else {
                    file.write(szBuffer, dwBytes);
                }
            }
        }
    }

    // Cleanup and exit
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
int ConvertRgb(const fs::path &file, int rgbe)
{
    fs::path buf{Dir};
    int i;
    size_t l;

    auto rgbp = ExtractEntry(ArchiveOffsets[rgbe], &l);
    ConvertPalette(rgbp.get());

    //
    //  Generate RGB File.
    //
    buf /= TILESET_PATH;
    buf /= file;
    buf.replace_extension(".rgb");
    CheckPath(buf);
    {
        std::ofstream f;
        f.exceptions(std::ofstream::failbit | std::ofstream::badbit);

        try {
            f.open(buf, std::ios::binary);
        } catch (std::system_error &e) {
            std::cout << "Can't open " << buf << std::endl;
            std::cerr << e.code().message() << std::endl;
        }

        if (!f.is_open()) {
            perror("");
            std::cout << "Can't open " << buf << std::endl;
            error("Memory error",
                  "Could not allocate enough memory to read archive.");
        }
        try {
            f.write(reinterpret_cast<char *>(rgbp.get()), l);
        } catch (std::system_error &e) {
            std::cout << "Can't write to " << buf << std::endl;
            std::cerr << e.code().message() << std::endl;
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
        std::ofstream f{buf, std::ios::binary};
        if (!f.is_open()) {
            perror("");
            std::cout << "Can't open " << buf << std::endl;
            error("Memory error",
                  "Could not allocate enough memory to read archive.");
        }
        f << "GIMP Palette\n# Stratagus "
          << static_cast<char>(toupper(file.c_str()[0])) << file.c_str() + 1
          << " -- GIMP Palette file\n";

        for (i = 0; i < 256; ++i) {
            // FIXME: insert nice names!
            f << std::to_string(rgbp[i * 3]) << " " << std::to_string(rgbp[i * 3 + 1])
              << " " << std::to_string(rgbp[i * 3 + 2]) << '\t' << '#'
              << std::to_string(i) << "\n";
        }
    }

    return 0;
}

//----------------------------------------------------------------------------
//  Tileset
//----------------------------------------------------------------------------

/**
**  Decode a minitile into the image.
*/
void DecodeMiniTile(Image &image, int ix, int iy, int iadd, unsigned char *mini,
                    int index, int flipx, int flipy)
{
    static const int flip[] = {7, 6, 5, 4, 3, 2, 1, 0, 8};
    int x;
    int y;

    for (y = 0; y < 8; ++y) {
        for (x = 0; x < 8; ++x) {
            image[(y + iy * 8) * iadd + ix * 8 + x] =
                mini[index + (flipy ? flip[y] : y) * 8 + (flipx ? flip[x] : x)];
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

    numtiles = msize / 32;

    width = TILE_PER_ROW * 32;
    height = ((numtiles + TILE_PER_ROW - 1) / TILE_PER_ROW) * 32;
    Image image{height, width};

    for (i = 0; i < numtiles; ++i) {
        mp = (const unsigned short *)(mega + i * 32);
        if (i < 16) { // fog of war
            for (y = 0; y < 32; ++y) {
                offset = i * 32 * 32 + y * 32;
                std::memcpy(image.ptr() + (i % TILE_PER_ROW) * 32 +
                            (((i / TILE_PER_ROW) * 32) + y) * width,
                            mini + offset, 32);
            }
        } else { // normal tile
            for (y = 0; y < 4; ++y) {
                for (x = 0; x < 4; ++x) {
                    offset = ConvertLE16(mp[x + y * 4]);
                    DecodeMiniTile(image, x + ((i % TILE_PER_ROW) * 4),
                                   y + (i / TILE_PER_ROW) * 4, width, mini,
                                   (offset & 0xFFFC) * 16, offset & 2, offset & 1);
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

    size_t megl;
    fs::path buf{};

    auto palp = ExtractEntry(ArchiveOffsets[pale], NULL);
    auto megp = ExtractEntry(ArchiveOffsets[mege], &megl);
    auto minp = ExtractEntry(ArchiveOffsets[mine], NULL);
    auto mapp = ExtractEntry(ArchiveOffsets[mape], NULL);

    Image image = ConvertTile(minp.get(), megp.get(), megl);

    ConvertPalette(palp.get());
    buf = Dir;
    buf /= TILESET_PATH;
    buf /= file;
    buf.replace_extension(".png");
    CheckPath(buf);
    SavePNG(buf, image, palp.get(), 1);

    return 0;
}

//----------------------------------------------------------------------------
//  Graphics
//----------------------------------------------------------------------------

/**
**  Decode a entry(frame) into image.
*/
void DecodeGfxEntry(int index, unsigned char *start, unsigned char *image,
                    int ix, int iy, int iadd)
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

    rows = start + offset - 6;
    dp = image + xoff - ix + (yoff - iy) * iadd;

    for (h = 0; h < height; ++h) {
        sp = rows + AccessLE16(rows + h * 2);
        for (w = 0; w < width;) {
            ctrl = *sp++;
            if (ctrl & 0x80) { // transparent
                ctrl &= 0x7F;
                memset(dp + h * iadd + w, 255, ctrl);
                w += ctrl;
            } else if (ctrl & 0x40) { // repeat
                ctrl &= 0x3F;
                memset(dp + h * iadd + w, *sp++, ctrl);
                w += ctrl;
            } else { // set pixels
                ctrl &= 0x3F;
                memcpy(dp + h * iadd + w, sp, ctrl);
                sp += ctrl;
                w += ctrl;
            }
        }
    }
}

/**
**  Decode a entry(frame) into image.
*/
void DecodeGfuEntry(int index, unsigned char *start, unsigned char *image,
                    int ix, int iy, int iadd)
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
Image ConvertGraphic(int gfx, unsigned char *bp, unsigned char *bp2,
                     size_t start2)
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

    // Find best image size
    minx = 999;
    miny = 999;
    best_width = 0;
    best_height = 0;
    for (i = 0; i < count; ++i) {
        unsigned char *p;
        size_t xoff;
        size_t yoff;
        size_t width;
        size_t height;

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

    minx = 0;
    miny = 0;

    if (gfx) {
        best_width = max_width;
        best_height = max_height;
        IPR = 5;           // st*rcr*ft 17!
        if (count < IPR) { // images per row !!
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
    Image image{best_height *(length / IPR), best_width * IPR};
    image.fill(255);

    if (gfx) {
        for (size_t i = 0; i < count; ++i) {
            // Hardcoded support for worker with resource repairing
            if (i >= start2 && bp2) {
                DecodeGfxEntry(i, bp2,
                               image.ptr() + best_width * (i % IPR) +
                               best_height * best_width * IPR * (i / IPR),
                               minx, miny, best_width * IPR);
            } else {
                DecodeGfxEntry(i, bp,
                               image.ptr() + best_width * (i % IPR) +
                               best_height * best_width * IPR * (i / IPR),
                               minx, miny, best_width * IPR);
            }
        }
    } else {
        for (size_t i = 0; i < count; ++i) {
            DecodeGfuEntry(i, bp,
                           image.ptr() + best_width * (i % IPR) +
                           best_height * best_width * IPR * (i / IPR),
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
    std::unique_ptr<unsigned char[]> gfxp2;

    auto palp = ExtractEntry(ArchiveOffsets[pale], NULL);
    auto gfxp = ExtractEntry(ArchiveOffsets[gfxe], NULL);
    if (gfxe2) {
        gfxp2 = ExtractEntry(ArchiveOffsets[gfxe2], NULL);
    } else {
        gfxp2 = NULL;
    }

    auto image = ConvertGraphic(1, gfxp.get(), gfxp2.get(), start2);

    ConvertPalette(palp.get());
    fs::path buf = Dir;
    buf /= GRAPHICS_PATH;
    buf /= file;
    buf.replace_extension(".png");
    CheckPath(buf);
    SavePNG(buf, image, palp.get(), 1);

    return 0;
}

/**
**  Convert a uncompressed graphic to my format.
*/
int ConvertGfu(const char *file, int pale, int gfue)
{
    fs::path buf;

    auto palp = ExtractEntry(ArchiveOffsets[pale], NULL);
    auto gfup = ExtractEntry(ArchiveOffsets[gfue], NULL);

    auto image = ConvertGraphic(0, gfup.get(), NULL, 0);

    ConvertPalette(palp.get());
    buf = Dir;
    buf /= GRAPHICS_PATH;
    buf /= file;
    buf.replace_extension(".png");
    CheckPath(buf);
    SavePNG(buf, image, palp.get(), 1);

    return 0;
}

/**
**  Split up and convert uncompressed graphics to seperate PNGs
*/
int ConvertGroupedGfu(const char *path, int pale, int gfue, int glist)
{
    int i;
    const GroupedGraphic *gg;

    auto palp = ExtractEntry(ArchiveOffsets[pale], NULL);
    auto gfup = ExtractEntry(ArchiveOffsets[gfue], NULL);

    auto image = ConvertGraphic(0, gfup.get(), NULL, 0);

    ConvertPalette(palp.get());

    for (i = 0; GroupedGraphicsList[glist][i].Name[0]; ++i) {
        gg = &GroupedGraphicsList[glist][i];

        // hack for expansion/original difference
        if (gg->Y + gg->Height > image.height) {
            break;
        }

        // hack for multiple palettes
        if (i == 3 && strstr(path, "widgets")) {
            palp = ExtractEntry(ArchiveOffsets[14], NULL);
            ConvertPalette(palp.get());
        }
        fs::path buf{};
        buf = Dir;
        buf /= GRAPHICS_PATH;
        buf /= path;
        buf /= gg->Name;
        buf.replace_extension(".png");
        CheckPath(buf);
        SavePNG(buf, image, gg->X, gg->Y, gg->Width, gg->Height, image.width,
                palp.get(), 1);
    }

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
    fs::path buf{};
    size_t l;

    if (justconvert == false) {
        auto pudp = ExtractEntry(ArchiveOffsets[pude], &l);
        buf = Dir;
        buf /= PUD_PATH;
        buf /= file;
        CheckPath(buf);
        // FIXME: Check that this makes sense.
        //  Here I am assuming that the strrchr below was to get the parent path.
        buf = buf.parent_path();
        // *strrchr(buf, '/') = '\0';

        PudToStratagus(
            pudp.get(), l,
            /*strrchr(file, '/') + 1-- this should be just the file part.*/
            file.filename(), buf);
    } else {
        fs::path pudfile{};
        size_t filesize = 0;
        buf = Dir;
        buf /= file;
        pudfile = buf;
        CheckPath(buf);
        if (!fs::exists(buf) && fs::is_regular_file(buf)) {
            std::cout << "Can't open pud file: " << buf << std::endl;
            return;
        }
        filesize = fs::file_size(buf);
        auto pudp = read_file_to_vector(buf);
        if (!pudp.size()) {
            std::cout << "Can't open pud file: " << buf << std::endl;
            return;
        }

        // FIXME: See Note above.
        buf = buf.parent_path();
        //*strrchr(buf, '/') = '\0';

        PudToStratagus(&pudp[0], filesize,
                       /*strrchr(file, '/') + 1--Similar to above*/ file.filename(),
                       buf);
        fs::remove(pudfile);
    }
}

/**
**	Convert puds that are in their own file
*/
template <size_t N> void ConvertFilePuds(std::array<fs::path, N> &pudlist)
{
    for (size_t i = 0; i < pudlist.size(); ++i) {
        fs::path origname{};
        if (CDType & CD_UPPER) {
            std::string filename{};
            origname = pudlist[i];
            filename = pudlist[i].string();
            std::transform(filename.begin(), filename.end(), filename.begin(),
                           ::toupper);
            pudlist[i] = filename;
        }
        fs::path pudname = ArchiveDir;
        pudname /= pudlist[i];
        if (!fs::exists(pudname) || !fs::is_regular_file(pudname)) {
            continue;
        }
        size_t pud_data_size;
        std::vector<unsigned char> puddata{};
        {
            std::ifstream f;
            try {
                f.open(pudname, std::ios::binary);
            } catch (std::system_error &e) {
                std::cout << "Can't open " << pudname << std::endl;
                std::cerr << e.code().message() << std::endl;
                return;
            }

            pud_data_size = fs::file_size(pudname);
            puddata.resize(pud_data_size);
            f.read(reinterpret_cast<char *>(puddata.data()), puddata.size());
        }

        fs::path base = pudlist[i];
        base = base.stem();

        if (CDType & CD_UPPER) {
            pudlist[i] = origname;
        }
        fs::path outdir = Dir;
        outdir /= "maps";
        outdir /= fs::relative(pudlist[i], "../puds/").parent_path();

        pudname = outdir;
        pudname /= "dummy";
        CheckPath(pudname);

        PudToStratagus(puddata.data(), pud_data_size, base, outdir);
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
    int h;
    int w;

    bp = start + 5; // skip "FONT "
    count = FetchByte(bp);
    if (CDType & CD_RUSSIAN) {
        // hack to show last letter in font
        count -= 31;
    } else {
        count -= 32;
    }

    max_width = FetchByte(bp);
    max_height = FetchByte(bp);

    IPR = 15; // 15 characters per row
    image_width = max_width * IPR;
    image_height = (count + IPR - 1) / IPR * max_height;

    std::vector<uint32_t> offsets;
    offsets.resize(count);
    for (i = 0; i < count; ++i) {
        offsets[i] = FetchLE32(bp);
    }

    Image image{image_height, image_width};
    image.fill(255);

    for (i = 0; i < count; ++i) {
        if (!offsets[i]) {
            continue;
        }
        bp = start + offsets[i];
        width = FetchByte(bp);
        height = FetchByte(bp);
        xoff = FetchByte(bp);
        yoff = FetchByte(bp);

        dp = image.ptr() + (i % IPR) * max_width +
             (i / IPR) * image_width * max_height;
        dp += xoff + yoff * image_width;
        h = w = 0;
        bool toBreak = false;
        for (;;) {
            int ctrl;

            ctrl = FetchByte(bp);
            w += (ctrl >> 3) & 0x1F;
            while (w >= width) {
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
    Image image;
    auto palp = ExtractEntry(ArchiveOffsets[pale], NULL);
    {
        auto fntp = ExtractEntry(ArchiveOffsets[fnte], NULL);
        image = ConvertFnt(fntp.get());
    }
    ConvertPalette(palp.get());

    auto buf = Dir;
    buf /= FONT_PATH;
    buf /= file;
    buf.replace_extension(".png");
    CheckPath(buf);
    if (!strcmp(file, "game")) {
        game_font_width = image.width / 15;
    }
    if (CDType & CD_RUSSIAN) {
        FixFont(image);
    }
    SavePNG(buf, image, palp.get(), 1);

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
            out[x] =
                image[i * image.height / nh * image.width + j * image.width / nw];
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
    // Workaround for MAC expansion CD
    if (CDType & CD_MAC) {
        if (imge >= 94 && imge <= 103) {
            imge += 7;
        }
        if (pale == 93) {
            pale += 7;
        }
    }

    std::shared_ptr<unsigned char[]> palp =
        ExtractEntry(ArchiveOffsets[pale], NULL);
    if (pale == 27 && imge == 28) {
        Pal27 = palp;
    }
    Image image;
    {
        auto imgp = ExtractEntry(ArchiveOffsets[imge], NULL);
        image = ConvertImg(imgp.get());
    }

    ConvertPalette(palp.get());

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
    SavePNG(buf, image, palp.get(), 0);

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
    size_t width;
    size_t height;

    (void)FetchLE16(bp); // hotx
    (void)FetchLE16(bp); // hoty
    width = FetchLE16(bp);
    height = FetchLE16(bp);

    Image image{height, width};

    for (size_t i = 0; i < width * height; ++i) {
        image[i] = bp[i] ? bp[i] : 255;
    }

    return image;
}

/**
**  Convert a cursor to my format.
*/
int ConvertCursor(const std::string &file, int pale, int cure)
{
    std::shared_ptr<unsigned char[]> palp;
    fs::path buf{};

    if (pale == 27 && cure == 314 && Pal27) { // Credits arrow (Blue arrow NW)
        palp = Pal27;
    } else {
        palp = ExtractEntry(ArchiveOffsets[pale], NULL);
    }
    Image image;
    {
        auto curp = ExtractEntry(ArchiveOffsets[cure], NULL);
        image = ConvertCur(curp.get());
    }
    ConvertPalette(palp.get());
    buf = Dir;
    buf /= CURSOR_PATH;
    buf /= file;
    buf.replace_extension(".png");
    CheckPath(buf);
    SavePNG(buf, image, palp.get(), 1);

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
    fs::path buf{};
    gzFile gf;
    size_t l;

    auto wavp = ExtractEntry(ArchiveOffsets[wave], &l);
    buf = Dir;
    buf /= SOUND_PATH;
    buf /= file;
    buf.replace_extension(".wav.gz");
    CheckPath(buf);
#ifndef WIN32
    gf = gzopen(buf.c_str(), "wb9");
#else
    gf = gzopen_w(buf.c_str(), "wb9");
#endif
    if (!gf) {
        perror("");
        std::cout << "Can't open " << buf << std::endl;
        error("Memory error", "Could not allocate enough memory to read archive.");
    }
    if (l != (size_t)gzwrite(gf, wavp.get(), l)) {
        std::cout << "Can't write " << l << " bytes" << std::endl;
        std::flush(std::cout);
    }

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

    fs::path buf{};
    size_t xmil;
    size_t midl;
    std::unique_ptr<unsigned char[]> midp;
    {
        auto xmip = ExtractEntry(ArchiveOffsets[xmi], &xmil);
        midp = TranscodeXmiToMid(xmip.get(), xmil, &midl);
    }
    buf = Dir;
    buf /= MUSIC_PATH;
    buf /= file;
    buf.replace_extension(".mid");
    CheckPath(buf);
    std::ofstream f{buf, std::ios::binary};
    if (!f.is_open()) {
        perror("");
        std::cout << "Can't open " << buf << std::endl;
        error("Memory error", "Could not allocate enough memory to read archive.");
    }
    f.write(reinterpret_cast<char *>(midp.get()), midl);
    if (f.fail()) {
        std::cout << "Can't write " << midl << " bytes" << std::endl;
        std::flush(std::cout);
    }

    return 0;
}

//----------------------------------------------------------------------------
//  Ripped music
//----------------------------------------------------------------------------

/**
**  Copy file
*/

int CopyFile(const fs::path &from, const fs::path &to, int overwrite)
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


/**
**  Copy ripped music
*/

int CopyMusic(void)
{
    fs::path buf1;
    fs::path buf2;
    char ext[4];
    int count = 0;

    for (size_t i = 0; i < MusicNames.size(); ++i) {
        strcpy(ext, "wav");
        buf1 = ArchiveDir;
        buf1 /= "music";
        buf1 /= MusicNames[i];
        buf1.replace_extension(".wav");
        if (!fs::exists(buf1)) {
            buf1.replace_extension(".ogg");
            if (!fs::exists(buf1)) {
                continue;
            }
        }
        std::cout << "Found ripped music file \"" << buf1 << "\"" << std::endl;
        std::flush(std::cout);
        buf2 = Dir;
        buf2 /= MUSIC_PATH;
        buf2 /= MusicNames[i];
        buf2.replace_extension(buf1.extension());

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
#ifndef WIN32
    std::string cmd {};
#else
    std::wstring cmd {};
#endif
    int ret;
    int count = 0;

    for (size_t i = 0; i < MusicNames.size(); ++i) {
        fs::path buf{};
        buf = Dir;
        buf /= MUSIC_PATH;
        buf /= MusicNames[i];
        buf.replace_extension(".wav");
        CheckPath(buf);

        fs::path output_path = buf;
        output_path.replace_extension(".ogg");

        if (!fs::exists(buf)) {
            continue;
        }
        cmd = _T("ffmpeg -y -i ");
        cmd += '"';
        cmd += buf;
        cmd += '"';
        cmd += _T(" ");
        cmd += '"';
        cmd += output_path;
        cmd += '"';

#ifndef WIN32
        ret = system(cmd.c_str());
#else
        ret = _wsystem(cmd.c_str());
#endif

        fs::remove(buf);

        if (ret != 0) {
            std::cout << "Can't convert wav sound " << MusicNames[i]
                      << " to ogg format. Is ffmpeg installed in PATH?" << std::endl;
            std::flush(std::cout);
        }

        ++count;
    }
    if (CDType & CD_BNE) {
        for (size_t i = 0; i < BNEMusicNames.size(); ++i) {
            fs::path buf{};
            buf = Dir;
            buf /= MUSIC_PATH;
            buf /= BNEMusicNames[i];
            buf.replace_extension(".wav");
            CheckPath(buf);

            fs::path output_path = buf;
            output_path.replace_extension(".ogg");

            if (!fs::exists(buf)) {
                continue;
            }
            cmd = _T("ffmpeg -y -i ");
            cmd += '"';
            cmd += buf;
            cmd += '"';
            cmd += _T(" ");
            cmd += '"';
            cmd += output_path;
            cmd += '"';
#ifndef WIN32
            ret = system(cmd.c_str());
#else
            ret = _wsystem(cmd.c_str());
#endif

            fs::remove(buf);

            if (ret != 0) {
                std::cout << "Can't convert wav sound " << BNEMusicNames[i]
                          << " to ogg format. Is ffmpeg installed in PATH?"
                          << std::endl;
                std::flush(std::cout);
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
    size_t l;
    int ret;

    fs::path buf{};
    buf = Dir;
    buf /= file;
    buf.replace_extension(".smk");
    CheckPath(buf);
    if (justconvert == false) {
        auto vidp = ExtractEntry(ArchiveOffsets[video], &l);
        std::ofstream f;
        f.exceptions(std::ofstream::failbit | std::ofstream::badbit);

        try {
            f.open(buf, std::ios::binary);
        } catch (std::system_error &e) {
            std::cout << "Can't open " << buf << std::endl;
            std::cerr << e.code().message() << std::endl;
        }

        try {
            f.write(reinterpret_cast<char *>(vidp.get()), l);
        } catch (std::system_error &e) {
            std::cout << "Can't write " << l << " bytes" << std::endl;
            std::cerr << e.code().message() << std::endl;
            std::flush(std::cout);
        }
    }

    fs::path output_file = buf;
    output_file.replace_extension(".ogv");

#ifndef WIN32
    std::string cmd;
#else
    std::wstring cmd;
#endif
    cmd = _T("ffmpeg -y -i ");
    cmd += '"';
    cmd += buf;
    cmd += '"';
    cmd += _T(" -codec:v libtheora -qscale:v 31 -codec:a libvorbis -qscale:a 15 "
              "-pix_fmt yuv420p ");
    if (CDType & CD_BNE) {
        cmd += _T("-aspect 4:3 -vf scale=640:0,setsar=1:1 ");
    }
    cmd += '"';
    cmd += output_file;
    cmd += '"';
#ifndef WIN32
    ret = system(cmd.c_str());
#else
    ret = _wsystem(cmd.c_str());
#endif
    remove(buf);

    if (ret != 0) {
        fs::remove(output_file);
        std::cout << "Can't convert video " << buf
                  << " to ogv format. Is ffmpeg installed in PATH?" << std::endl;
        std::flush(std::cout);
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
std::unique_ptr<unsigned char[]> ConvertString(unsigned char *buf, size_t len)
{

    unsigned char *p;
    size_t i;

    if (len == 0) {
        len = strlen((char *)buf);
    }
    std::unique_ptr<unsigned char[]> str =
        std::make_unique<unsigned char[]>(2 * len + 1);
    p = str.get();

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
int ConvertText(const std::string &file, int txte, int ofs)
{
    gzFile gf;
    size_t l;
    size_t l2;

    // workaround for German/UK/Australian CD's
    if (!(CDType & CD_EXPANSION) && (CDType & (CD_GERMAN | CD_UK | CD_RUSSIAN))) {
        --txte;
    }

    // workaround for MAC expansion CD
    if ((CDType & CD_MAC) && txte >= 99) {
        txte += 6;
    }

    auto txtp = ExtractEntry(ArchiveOffsets[txte], &l);

    fs::path buf{};
    buf = Dir;
    buf /= TEXT_PATH;
    buf /= file;
    buf.replace_extension(".txt.gz");
    CheckPath(buf);
#ifndef WIN32
    gf = gzopen(buf.c_str(), "wb9");
#else
    gf = gzopen_w(buf.c_str(), "wb9");

#endif
    if (!gf) {
        std::cout << "Can't open " << buf << std::endl;
        perror("");
        error("Memory error", "Could not allocate enough memory to read archive.");
    }
    auto str = ConvertString(txtp.get() + ofs, l - ofs);
    l2 = strlen((char *)str.get()) + 1;

    if (l2 != (size_t)gzwrite(gf, str.get(), l2)) {
        std::cout << "Can't write " << l2 << " bytes" << std::endl;
        std::flush(std::cout);
    }

    gzclose(gf);

    return 0;
}

/**
**  Convert text to my format.
*/
int SetupNames(const char *file __attribute__((unused)),
               int txte __attribute__((unused)))
{
    unsigned char *txtp;
    const unsigned short *mp;
    unsigned u;
    unsigned n;

    // txtp = ExtractEntry(ArchiveOffsets[txte], &l);
    txtp = Names;
    mp = (const unsigned short *)txtp;
    UnitNames.resize(110);

    n = ConvertLE16(mp[0]);
    for (u = 1; u < std::min<unsigned>(n, UnitNames.size()); ++u) {
        for (char const *cursor = (char *)txtp + ConvertLE16(mp[u]); *cursor;
             cursor++) {
            UnitNames[u].push_back(*cursor);
        }
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
    char const *tp;
    int i;
    int f;

    for (sp = input, dp = buf; *sp;) {
        if (*sp == '%') {
            f = 0;
            if (*++sp == '-') {
                f = 1;
                ++sp;
            }
            i = strtol(sp, &strsp, 0);
            sp = strsp;
            tp = UnitNames[i].c_str();
            if (f) {
                tp = strchr(tp, ' ') + 1;
            }
            while (*tp) { // make them readabler
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

    return buf;
}

//----------------------------------------------------------------------------
//  Import the campaigns
//----------------------------------------------------------------------------

/**
**  FIXME: docu
*/
int CampaignsCreate(int txte, int ofs)
{
    unsigned char *CampaignData[2][26][10];
    unsigned char *current;
    unsigned char *next;
    unsigned char *nextobj;
    unsigned char *currentobj;
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

    std::vector<unsigned char> objectives{};
    {
        // FIXME: this is a bit ugly, but works for now.
        auto objectives_base = ExtractEntry(ArchiveOffsets[txte], &l);
        if (!objectives_base) {
            std::cout << "Objectives allocation failed" << std::endl;
            error("Memory error",
                  "Could not allocate enough memory to read archive.");
        }

        objectives.resize(l + 1);
        for (size_t i = 0; i < l; i++) {
            objectives[i] = objectives_base[i];
        }
    }
    objectives[l] = '\0';

    // Now Search from start of objective data
    levelno = 0;
    race = 0;

    // Extract all the values for objectives
    if (expansion) {
        expansion = 52;
    } else {
        expansion = 28;
    }
    current = &objectives[0] + ofs;
    for (l = 0; l < (size_t)expansion; ++l) {
        next = current + strlen((char *)current) + 1;

        noobjs = 1; // Number of objectives is zero.
        currentobj = current;
        while ((nextobj = (unsigned char *)strchr((char *)currentobj, '\n')) !=
               NULL) {
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
            // Open Relevant file, to write stuff too.
            fs::path buf{};
            buf = Dir;
            buf /= TEXT_PATH;
            buf /= Todo[2 * levelno + 1 + race + 5].File + "_c2.sms";

            CheckPath(buf);
            std::ofstream out_level;
            out_level.exceptions(std::ofstream::failbit | std::ofstream::badbit);

            try {
                out_level.open(buf, std::ios::binary);
            } catch (std::system_error &e) {
                std::cout << "Can't open " << buf << std::endl;
                std::cerr << e.code().message() << std::endl;
            }

            {
                auto str = ConvertString(CampaignData[race][levelno][0], 0);
                out_level << "title = \"" << str.get() << "\"\n";
            }
            out_level << "objectives = {";
            for (noobjs = 1; noobjs < 10; ++noobjs) {
                if (CampaignData[race][levelno][noobjs] != NULL) {
                    auto str = ConvertString(CampaignData[race][levelno][noobjs], 0);
                    out_level << (noobjs > 1 ? "," : "") << "\"" << str.get() << "\"";
                }
            }
            out_level << "}\n";
        }
    }

    return 0;
}

//----------------------------------------------------------------------------
//  Fix SPK translation
//----------------------------------------------------------------------------

void FixTranslation(const fs::path &translation)
{
    if (fs::exists(translation)) {
        auto data = read_file_to_vector(translation);
        if (!data.size()) {
            return;
        }
        std::ofstream oFile{translation, std::ios::binary};
        if (!oFile.is_open()) {
            return;
        }
        auto p = data.data();
        for (size_t i = 0; i < data.size(); ++i, ++p) {
            unsigned char c = *p;
            if (c >= 0x80) {
                if (c >= 0xE0 && c < 0xF0) {
                    c -= 0x30;
                }
                oFile << '0xC2';
                oFile << c;
            } else {
                oFile << c;
            }
        }
    }
}

#define OUR_EXPANSION_SUBDIR "wargus.exp.data"

void copyArchive(const fs::path &partialPath)
{
    std::ifstream source;
    std::ifstream target;
    fs::path srcname = ArchiveDir;
    fs::path tgtname = Dir;

    if (CDType & CD_EXPANSION && !(CDType & CD_BNE)) {
        // expansion CD, copy the archive in a subdir
        tgtname /= OUR_EXPANSION_SUBDIR;
    }
    tgtname /= partialPath;
    srcname /= partialPath;

    if (fs::exists(tgtname)) {
        return;
    }

    CheckPath(tgtname);
    std::error_code ec{};
    fs::copy_file(srcname, tgtname, ec);
    if (ec) {
        std::cerr << "Error copying files (" << srcname << ", " << tgtname
                  << "): " << ec.message() << std::endl;
    }
    std::cout << "Copied " << srcname << "->" << tgtname << std::endl;
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
destination-directory\tDirectory where the extracted files are placed.\n",
           NameLine, name);
    std::flush(std::cout);
}

int ExtractImplicitExpansion(char **argv, int a)
{
    std::cout << "Extracting from expansion subdir" << std::endl;
    // detect if the expansion directory is next to the data directory
    if (ArchiveDir.string().find(OUR_EXPANSION_SUBDIR) != std::string::npos) {
        // we're already trying to extract from our expansion subdir, don't recurse
        return -1;
    }
    fs::path buf = ArchiveDir;
    buf /= OUR_EXPANSION_SUBDIR;

    if (fs::exists(buf)) {
        // expansion subdir available, extract from it
        fs::path ExpansionArchiveDir = ArchiveDir;
        ExpansionArchiveDir /= OUR_EXPANSION_SUBDIR;

        if (ArchiveDir != argv[a]) {
            std::cerr << "Assertion error: expected argv[a] (" << argv[a]
                      << ") to point to ArchiveDir (" << ArchiveDir << ")"
                      << std::endl;
            exit(-1);
        }



#ifdef WIN32
        //FIXME: This is probably overall the wrong solution, but let's do it for now.
        size_t count = 0;
        auto temp = argv;
        while (temp++) {
            count++;
        }
        std::unique_ptr<wchar_t *[]> n_argv = std::make_unique<wchar_t *[]>(count);
        for (size_t i = 0; i < count; i++) {
            if (i == a) {
                n_argv[a] = const_cast<wchar_t *>(ExpansionArchiveDir.c_str());
            } else {
                auto r = MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, argv[i], -1, nullptr, 0);
                n_argv[i] = static_cast<wchar_t *>(malloc((r + 1) * sizeof(*(n_argv[i]))));
                r = MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, argv[i], -1, n_argv[i], r + 1);
                n_argv[i][r] = '\0';
            }

        }
        int execresult = _wexecv(n_argv[0], n_argv.get());
        for (size_t i = 0; i < count; i++) {
            if (i != a) {
                free(n_argv[i]);
            }
        }
#else
        argv[a] = const_cast<char *>(ExpansionArchiveDir.c_str());
        int execresult = execv(argv[0], argv);
#endif
        if (execresult) {
            std::cerr
                    << "an error occurred trying to extract from the expansion archives"
                    << std::endl;
            exit(-1);
        }
    }
    return -1;
}

#ifdef WIN32
#include <io.h>
#include <tchar.h>

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
    int *fds = (int *)data;
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

    wchar_t *stdoutpath = GetExtractionLogPath(L"Wargus", Dir.c_str());
    int logfilefd =
        _wopen(stdoutpath, _O_WRONLY | _O_CREAT | _O_BINARY | _O_TRUNC, _S_IWRITE);

    // make stdout/stderr write into the write ends of the pipes
    _dup2(stdoutPipes[1], 1);
    _dup2(stderrPipes[1], 2);
    // start a thread to read from the read ends of those pipes, and write to the
    // old stdout/stderr and to a logfile

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
void teeStdout() {}
void endTee() {}
#endif

/**
**		Main
*/
#undef main
int main(int argc, char **argv)
{
    unsigned u;
    int expansion_cd = 0;
    int video = 0;
    int rip = 0;
    int a = 1;
    fs::path filename;
    fs::path buf;

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
            std::cout << VERSION << std::endl;
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
    fs::path extraPath = ArchiveDir;
    extraPath /= "data/rezdat.war";
    if (fs::exists(extraPath)) {
        extraPath = ArchiveDir;
        extraPath /= "data";
        ArchiveDir = extraPath;
    } else {
        extraPath = ArchiveDir;
        extraPath /= "DATA/REZDAT.WAR";
        if (fs::exists(extraPath)) {
            extraPath = ArchiveDir;
            extraPath /= "DATA";
            ArchiveDir = extraPath;
        }
    }

    if (argc == 3) {
        Dir = argv[a + 1];
    } else {
        Dir = "data";
    }
    teeStdout();
    buf = Dir;
    buf /= "extracted";
    {
        std::ifstream f;
        f.exceptions(std::ifstream::failbit | std::ifstream::badbit);

        try {
            f.open(buf);
        } catch (std::system_error &e) {
            std::cout << "Can't open " << buf << std::endl;
            std::cerr << e.code().message() << std::endl;
        }

        if (f.is_open()) {
            char version[20];
            int len = 0;
            if (f.read(version, 20)) {
                len = 1;
            }
            f.close();
            if (len != 0 && strcmp(version, VERSION) == 0) {
                std::cout << "Note: Data is already extracted in Dir \"" << Dir
                          << "\" with this version of wartool" << std::endl;
                std::flush(std::cout);
            }
        }
    }
    // Detect if CD is Mac/Dos, Expansion/Original/BNE, and language
    buf = ArchiveDir;
    buf /= "support/tomes/tome.1";
    if (fs::exists(buf)) {
        filename = ArchiveDir;
        filename /= "support/tomes/tome.4";
        std::cout << "Detected BNE CD" << std::endl;
        std::flush(std::cout);
        CDType |= CD_BNE | CD_EXPANSION | CD_US;
    } else if (buf = ArchiveDir / fs::path("/Support/TOMES/TOME.1");
               fs::exists(buf)) {
        filename = ArchiveDir;
        filename /= "/Support/TOMES/TOME.4";
        std::cout << "Detected BNE CD Captialized" << std::endl;
        std::flush(std::cout);
        CDType |= CD_BNE | CD_BNE_CAPS | CD_EXPANSION | CD_US;
    } else if (buf = ArchiveDir / fs::path("/SUPPORT/TOMES/TOME.1");
               fs::exists(buf)) {
        filename = ArchiveDir;
        filename /= "/SUPPORT/TOMES/TOME.4";
        std::cout << "Detected BNE CD Uppercase" << std::endl;
        std::flush(std::cout);
        CDType |= CD_BNE | CD_BNE_UPPER | CD_EXPANSION | CD_US;
    } else {
        buf = ArchiveDir;
        buf /= "rezdat.war";
        filename = ArchiveDir;
        filename /= "strdat.war";
        if (!fs::exists(buf)) {
            buf = ArchiveDir;
            buf /= "REZDAT.WAR";
            filename = ArchiveDir;
            filename /= "STRDAT.WAR";
            CDType |= CD_UPPER;
        }
        if (!fs::exists(buf)) {
            CDType |= CD_MAC | CD_US;
            buf = ArchiveDir;
            buf /= "War Resources";
            if (!fs::exists(buf)) {
                if (ExtractImplicitExpansion(argv, a)) {
                    // try extracting from implicitly copied expansion data from
                    // a previous expansion-only extraction
                    std::cout << "Could not find Warcraft 2 Data" << std::endl;
                    error("Data not found", "Could not find Warcraft 2 data in folder. "
                          "Make sure you have selected the DATA "
                          "directory of the DOS version, "
                          "or the root of the Battle.net CD.");
                }
            }
            size_t file_size = fs::file_size(buf);
            if (expansion_cd == -1 || (expansion_cd != 1 && file_size != 2876978)) {
                std::cout << "Detected original MAC CD" << std::endl;
                std::flush(std::cout);
                std::flush(std::cout);
            } else {
                std::cout << "Detected expansion MAC CD" << std::endl;
                std::flush(std::cout);
                CDType |= CD_EXPANSION;
            }
        } else {
            size_t file_size = fs::file_size(buf);
            if (file_size != 2811086) {
                expansion_cd = 0;
                size_t filename_size = fs::file_size(filename);

                switch (filename_size) {
                    case 51550:
                        std::cout << "Detected US original DOS CD" << std::endl;
                        std::flush(std::cout);
                        CDType |= CD_US;
                        break;
                    case 53874:
                        std::cout << "Detected Italian original DOS CD" << std::endl;
                        std::flush(std::cout);
                        CDType |= CD_ITALIAN;
                        break;
                    case 55014:
                        std::cout << "Detected Spanish original DOS CD" << std::endl;
                        std::flush(std::cout);
                        CDType |= CD_SPANISH;
                        break;
                    case 55724:
                        std::cout << "Detected German original DOS CD" << std::endl;
                        std::flush(std::cout);
                        CDType |= CD_GERMAN;
                        break;
                    case 51451:
                        std::cout << "Detected UK/Australian original DOS CD" << std::endl;
                        std::flush(std::cout);
                        CDType |= CD_UK;
                        break;
                    case 52883:
                        std::cout << "Detected Portuguese original DOS CD" << std::endl;
                        std::flush(std::cout);
                        CDType |= CD_PORTUGUESE;
                        break;
                    case 55079:
                        std::cout << "Detected French original DOS CD" << std::endl;
                        std::flush(std::cout);
                        CDType |= CD_FRENCH;
                        break;
                    case 52152:
                        std::cout << "Detected Russian SPK DOS CD" << std::endl;
                        std::flush(std::cout);
                        CDType |= CD_RUSSIAN;
                        break;

                    default:
                        std::cout << "Could not detect CD version:" << std::endl;
                        std::cout << "Defaulting to German original DOS CD" << std::endl;
                        std::flush(std::cout);
                        CDType |= CD_GERMAN;
                        break;
                }
            } else {
                size_t filename_size = fs::file_size(filename);
                switch (filename_size) {
                    case 74422:
                        std::cout << "Detected Russian expansion DOS CD" << std::endl;
                        std::flush(std::cout);
                        CDType |= CD_EXPANSION | CD_RUSSIAN;
                        break;
                    default:
                        std::cout << "Detected expansion DOS CD" << std::endl;
                        std::flush(std::cout);
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
        std::cout
                << "Please compile wartool with StormLib library to extract the data."
                << std::endl;
        error("Archive version error",
              "The Battle.net edition is not supported by this version of "
              "the extractor tool. Please compile wartool with StormLib.");
#endif
    }
    std::cout << "Extract from \"" << ArchiveDir << "\" to \"" << Dir << "\""
              << std::endl;
    std::cout << "Please be patient, the data may take a couple of minutes to "
              "extract..."
              << std::endl;
    std::flush(std::cout);

    for (u = 0; u < sizeof(Todo) / sizeof(*Todo); ++u) {
        if (CDType & CD_MAC) {
            ConvertToMac(Todo[u].File);
        }
        // Should only be on the expansion cd
#ifdef DEBUG
        // std::cout << "%s:\n", ParseString(Todo[u].File));
        std::flush(std::cout);
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
        fs::path mpqfile{};
        fs::path extract{};
        std::string filename{};
        switch (Todo[u].Type) {
            case F:
                if (CDType & CD_BNE) {
                    for (size_t i = 0; i < BNEReplaceTable.size(); i += 2) {
                        if (BNEReplaceTable[i] == Todo[u].File) {
                            Todo[u].File = BNEReplaceTable[i + 1];
                            if (CDType & CD_BNE_CAPS) {
                                Todo[u].File = BNEReplaceTableCaps[i + 1];
                            } else if (CDType & CD_BNE_UPPER) {
                                // FIXME: clean up later, currently keeping original logic.
                                filename = Todo[u].File;
                                std::transform(filename.begin(), filename.end(), filename.begin(),
                                               ::toupper);
                                Todo[u].File = filename;
                            }
                            break;
                        }
                    }
                } else if (CDType & CD_UPPER) {
                    // FIXME: See above.
                    filename = Todo[u].File;
                    std::transform(filename.begin(), filename.end(), filename.begin(),
                                   ::toupper);
                    Todo[u].File = filename;
                }
                buf = ArchiveDir;
                buf /= Todo[u].File;
                std::cout << "Archive \"" << buf << "\"" << std::endl;
                std::flush(std::cout);
                if (ArchiveBuffer) {
                    CloseArchive();
                }

                OpenArchive(buf.c_str(), Todo[u].Arg1);
                copyArchive(Todo[u].File);
                break;
            case Q:
                if (!(CDType & CD_BNE)) {
                    std::cout << "Error - not a BNE disk" << std::endl;
                    error("Archive version error",
                          "This version of the CD is not supported");
                }
#ifdef USE_STORMLIB
                if (Todo[u].Arg1 == 1) { // local archive
                    mpqfile = Dir;
                    mpqfile /= Todo[u].MPQFile;
                    if (Todo[u].ArcFile == "DELETE") {
                        // delete
                        std::cout << "Deleting temporary MPQ file \"" << mpqfile << "\""
                                  << std::endl;
                        fs::remove(mpqfile);
                        continue;
                    }
                    std::cout << Todo[u].ArcFile << " from MPQ file \"" << mpqfile << "\""
                              << std::endl;
                } else {
                    std::string filename = Todo[u].MPQFile;
                    // initially all lowercase
                    std::transform(filename.begin(), filename.end(), filename.begin(),
                                   ::tolower);

                    // let's see....
                    mpqfile = ArchiveDir;
                    mpqfile /= filename;
                    if (!fs::exists(mpqfile)) {
                        // try with initial uppercase
                        filename[0] = toupper(filename[0]);
                        mpqfile = ArchiveDir;
                        mpqfile /= filename;
                    }
                    if (!fs::exists(mpqfile)) {
                        // try all uppercase
                        std::transform(filename.begin(), filename.end(), filename.begin(),
                                       ::toupper);
                        mpqfile = ArchiveDir;
                        mpqfile /= filename;
                    }
                    if (!fs::exists(mpqfile)) {
                        // try with alternative extension (mpq/exe)
                        filename = Todo[u].MPQFile;

                        // initially all lowercase
                        std::transform(filename.begin(), filename.end(), filename.begin(),
                                       ::tolower);

                        // swap extension
                        mpqfile = ArchiveDir;
                        mpqfile /= filename;
                        if (mpqfile.extension() == ".exe") {
                            mpqfile.replace_extension(".mpq");
                        } else if (mpqfile.extension() == ".mpq") {
                            mpqfile.replace_extension(".exe");
                        }
                    }
                    if (!fs::exists(mpqfile)) {
                        // try with initial uppercase
                        filename[0] = toupper(filename[0]);
                        mpqfile = ArchiveDir;
                        mpqfile /= filename;
                    }
                    if (!fs::exists(mpqfile)) {
                        // try all uppercase
                        std::transform(filename.begin(), filename.end(), filename.begin(),
                                       ::toupper);
                        mpqfile = ArchiveDir;
                        mpqfile /= filename;
                    }
                    if (!fs::exists(mpqfile)) {
                        mpqfile = ArchiveDir;
                        mpqfile /= Todo[u].MPQFile;
                        std::cerr << mpqfile << " not found!" << std::endl;
                        error(mpqfile, _T("I also tried different cases and tried both .mpq and "
                                          ".exe extensions\n"));
                    }
                    std::cout << Todo[u].File << " from MPQ file \"" << mpqfile << "\""
                              << std::endl;
                    // strip ArchiveDir and slash before copying
                    fs::path copyfile = mpqfile.filename();
                    copyArchive(copyfile);
                }
                extract = Dir;
                extract /= Todo[u].File;
                if (Todo[u].Arg2 == 1) { // compress
                    extract.replace_extension(extract.extension().string() +
                                              std::string(".gz"));
                }
                if (Todo[u].Arg2 == 2) { // video file
                    extract.replace_extension(extract.extension().string() +
                                              std::string(".smk"));
                }
                if (Todo[u].Arg2 == 8 && !rip) { // wav audio
                    continue;
                }
                if (ExtractMPQFile(mpqfile, Todo[u].ArcFile, extract,
                                   Todo[u].Arg2 == 1)) {
                    std::cout << "Failed to extract \"" << Todo[u].ArcFile << std::endl;
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
                ConvertRgb(Todo[u].File, Todo[u].Arg1);
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
                ConvertCursor(Todo[u].File, Todo[u].Arg1, Todo[u].Arg2);
                break;
            case M:
                ConvertXmi(Todo[u].File, Todo[u].Arg1);
                break;
            case W:
                ConvertWav(Todo[u].File, Todo[u].Arg1);
                break;
            case X:
                ConvertText(Todo[u].File, Todo[u].Arg1, Todo[u].Arg2);
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
                CampaignsCreate(Todo[u].Arg1, Todo[u].Arg2);
                break;
            default:
                break;
        }
    }

    ConvertFilePuds(OriginalPuds);
    ConvertFilePuds(ExpansionPuds);

    CopyMusic();

    if (rip && !(CDType & CD_BNE)) {
        buf = Dir;
        buf /= MUSIC_PATH;
        CheckPath(buf);
        rip = (RipMusic(expansion_cd, ArchiveDir, buf) == 0);
    }

    ConvertMusic();

    if (ArchiveBuffer) {
        CloseArchive();
    }

    buf = Dir;
    buf /= "scripts/wc2-config.lua";

    CheckPath(buf);
    std::ofstream f;
    f.exceptions(std::ofstream::failbit | std::ofstream::badbit);

    try {
        f.open(buf);
    } catch (std::system_error &e) {
        std::cout << "Can't open " << buf << std::endl;
        std::cerr << e.code().message() << std::endl;
    }

    if (!f.is_open()) {
        perror("");
        std::cout << "Can't open " << buf << std::endl;
        error("Memory error", "Could not allocate enough memory to read archive.");
    }
    f << "wargus.tales = false\n";

    if (expansion_cd) {
        f << "wargus.expansion = true\n";
    } else {
        f << "wargus.expansion = false\n";
    }
    if (rip) {
        f << "wargus.music_extension = \".ogg\"\n";
    } else {
        f << "wargus.music_extension = \".mid\"\n";
    }
    if (CDType & CD_BNE) {
        f << "wargus.bne = true\n";
    } else {
        f << "wargus.bne = false\n";
    }
    f << "wargus.game_font_width = " << game_font_width << "\n";
    f.close();

    buf = Dir;
    buf /= "extracted";
    try {
        f.open(buf);
    } catch (std::system_error &e) {
        std::cout << "Can't open " << buf << std::endl;
        std::cerr << e.code().message() << std::endl;
    }

    if (!f.is_open()) {
        perror("");
        std::cout << "Can't open " << buf << std::endl;
        error("Memory error", "Could not allocate enough memory to read archive.");
    }
    f << VERSION;
    f.close();

    buf = Dir;
    buf /= "/scripts/translate/ru_RU.po";
    FixTranslation(buf.c_str());

    buf = Dir;
    buf /= "/scripts/translate/stratagus-ru.po";
    FixTranslation(buf.c_str());

    buf = Dir;
    buf /= REEXTRACT_MARKER_FILE;

    try {
        f.open(buf);
    } catch (std::system_error &e) {
        std::cout << "Can't open " << buf << std::endl;
        std::cerr << e.code().message() << std::endl;
    }

    if (!f.is_open()) {
        perror("");
        std::cout << "Can't open " << buf << std::endl;
        error("Memory error", "Could not allocate enough memory to read archive.");
    }

    f << "data copied for re-extraction";
    f.close();

    std::cout << "Done." << std::endl;

    ExtractImplicitExpansion(argv, a);

    endTee();

    return 0;
}

//@}
