#ifndef PNGIO_HPP
#define PNGIO_HPP

#include <cstdlib>
#include <cassert>
#include <cstring>
#include <fstream>
#include <iostream>
#include "Image.hpp"
#if __has_include(<filesystem>)
#include <filesystem>
#elif __has_include(<experimental/filesystem>)
#include <experimental/filesystem>
namespace fs = std::experimental::filesystem;
#else
error "Missing the <filesystem> header."
#endif
#include "zlib.h"
#include "png.h"




// This file assumes the version of libpng is greater than 1.5.4 released on July 7, 2011. More than 10 years prior to the writing of these classes.


/*

  // set transformation

  // prepare image
  lines.resize(image.height);
  if (lines.size() != image.height) {
    png_destroy_write_struct(&png_ptr, &info_ptr);
    fclose(fp);
    return 1;
  }

  for (i = 0; i < image.height; ++i) {
    lines[i] = &image.data[0] + (i)*image.width;
  }

  png_write_image(png_ptr, &lines[0]);
  png_write_end(png_ptr, info_ptr);

  png_destroy_write_struct(&png_ptr, &info_ptr);
  return 0;


*/



class PNGWriter
{
    class PNGWriteStructure
    {
    public:
        PNGWriteStructure()
        {
            static_assert(PNG_LIBPNG_VER >= 10504, "Only supports libpng newer than 1.5.4");
            png_ptr = png_create_write_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);
            if (!png_ptr) {
                std::cerr << "Couldn't create a PNG write structure." << std::endl;
                errors = true;
                return;
            }
            info_ptr = png_create_info_struct(png_ptr);
            if (!info_ptr) {
                std::cerr << "Couldn't create a PNG info structure." << std::endl;
                errors = true;
                return;
            }

        }
        ~PNGWriteStructure()
        {
            if (png_ptr) {
                if (info_ptr) {
                    png_destroy_write_struct(&png_ptr, &info_ptr);
                } else {
                    png_destroy_write_struct(&png_ptr, nullptr);

                }
            }
        }
        operator bool()const
        {
            return !errors;
        }

        png_structp get()
        {
            return png_ptr;
        }
        png_infop info_get()
        {
            return info_ptr;
        }
    private:
        png_structp png_ptr{nullptr};
        png_infop info_ptr{nullptr};
        bool errors{false};
    };

public:
    PNGWriter(): png_ptr{}
    {

    }


    bool write(const std::filesystem::path &out_file, Image image, unsigned char *pal, int transparent)
    {
        return write(out_file, image, 0, 0, image.width, image.height, image.width, pal, transparent);
    }
    bool write(const std::filesystem::path &out_file, Image image, int x, int y, int w, size_t h,
               int pitch, unsigned char *pal, int transparent)
    {
        if (!png_ptr) {
            return !png_ptr;
        }
        if (setjmp(png_jmpbuf(png_ptr.get()))) {
            std::cerr << "Error in writing png file!" << std::endl;
            return false;
        }

        std::ofstream file(out_file, std::ios::binary);
        png_set_write_fn(png_ptr.get(), &file, internal_write, internal_flush);
        png_set_compression_level(png_ptr.get(), Z_BEST_COMPRESSION);


        png_set_IHDR(png_ptr.get(), png_ptr.info_get(), w, h, 8,
                     PNG_COLOR_TYPE_PALETTE, 0, PNG_COMPRESSION_TYPE_DEFAULT,
                     PNG_FILTER_TYPE_DEFAULT);
        png_set_PLTE(png_ptr.get(), png_ptr.info_get(), (png_colorp)pal, 256);


        if (transparent) {
            unsigned char *p;
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

            std::memset(trans, 0xFF, sizeof(trans));
            trans[255] = 0x0;
            png_set_tRNS(png_ptr.get(), png_ptr.info_get(), trans, 256, 0);
        }

        // write the file header information
        png_write_info(png_ptr.get(), png_ptr.info_get());

        // set transformation


        // prepare image
        std::vector<unsigned char *> lines;
        lines.resize(h);
        if (lines.size() != h) {
            return false;
        }

        for (size_t i = 0; i < h; ++i) {
            lines[i] = &image.data[0] + (i + y) * pitch + x;
        }

        png_write_image(png_ptr.get(), &lines[0]);
        png_write_end(png_ptr.get(), png_ptr.info_get());

        return !png_ptr;
    }
private:
    static void internal_write(png_structp png_ptr, png_bytep data, png_size_t length)
    {
        std::ostream *out_file = reinterpret_cast< std::ostream * >(png_get_io_ptr(png_ptr));
        assert(out_file);
        if (!out_file || !out_file->write(reinterpret_cast< char * >(data), length)) {
            png_error(png_ptr, "Error writing to stream.");
        }
    }
    static void internal_flush(png_structp png_ptr)
    {
        std::ostream *out_file = reinterpret_cast< std::ostream * >(png_get_io_ptr(png_ptr));
        assert(out_file);
        if (!out_file || !out_file->flush()) {
            png_error(png_ptr, "Error flushing.");
        }
    }


    PNGWriteStructure png_ptr{};
};

class PNGReader
{
public:
    PNGReader()
    {
        //Not Implemented!
        abort();
    }

};
































#endif // PNGIO_HPP
