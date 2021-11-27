#ifndef IMAGE_HPP
#define IMAGE_HPP
#include <iostream>
#include <vector>


class Image {
public:
  Image() = default;
  Image(size_t height, size_t width) : height{height}, width{width} {
    data.resize(height * width);
    fill(0);
  }
  unsigned char &operator[](size_t ind) {
    if (ind < data.size()) {
      return data[ind];
    } else {
      std::cerr << "Trying to write out of bounds: " << ind
                << " when size is: " << data.size() << std::endl;
      abort();
    }
  }
  const unsigned char &operator[](size_t ind) const {
    if (ind < data.size()) {
      return data[ind];
    } else {
      std::cerr << "Trying to write out of bounds: " << ind
                << " when size is: " << data.size() << std::endl;
      abort();
    }
  }
  void fill(unsigned char in) { std::fill(data.begin(), data.end(), in); }

  unsigned char *ptr() { return &data[0]; }
  std::vector<unsigned char> data;
  size_t height;
  size_t width;
};



#endif // IMAGE_HPP
