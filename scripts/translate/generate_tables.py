#!/usr/bin/env python3

from unidecode import unidecode

print("static const unsigned char utf8_europe_to_cp437[] = {")
for i in range(0xa0, 0xff + 1):
    if i % 16 == 0:
        print("    ", end="")
    print("0x%02x" % chr(i).encode("cp437", errors="replace").replace(b'?', b'\x00')[0], ", ", sep="", end="")
    if i % 16 == 15:
        print(f"// {hex(i - 15)}")
print("};\n")

print("static const unsigned char utf8_europe_to_cp1252[] = {")
for i in range(0xa0, 0xff + 1):
    if i % 16 == 0:
        print("    ", end="")
    print("0x%02x" % chr(i).encode("cp1252", errors="replace").replace(b'?', b'\x00')[0], ", ", sep="", end="")
    if i % 16 == 15:
        print(f"// {hex(i - 15)}")
print("};\n")

print("static const unsigned char utf8_europe_to_ascii[] = {")
for i in range(0xa0, 0xff + 1):
    if i % 16 == 0:
        print("    ", end="")
    replacement = unidecode(chr(i)) or "\x00"
    print("0x%02x" % replacement.encode('ascii')[0], ", ", sep="", end="")
    if i % 16 == 15:
        print(f"// {hex(i - 15)}")
print("};\n")

print("static const unsigned char utf8_cyrillic_to_ascii[] = {")
for i in range(0x400, 0x45f + 1):
    if i % 16 == 0:
        print("    ", end="")
    replacement = unidecode(chr(i)) or "\x00"
    print("0x%02x" % replacement.encode('ascii')[0], ", ", sep="", end="")
    if i % 16 == 15:
        print(f"// {hex(i - 15)}")
print("};\n")

print("static const unsigned char utf8_cyrillic_to_cp866[] = {")
for i in range(0x400, 0x45f + 1):
    if i % 16 == 0:
        print("    ", end="")
    print("0x%02x" % chr(i).encode("cp866", errors="replace").replace(b'?', b'\x00')[0], ", ", sep="", end="")
    if i % 16 == 15:
        print(f"// {hex(i - 15)}")
print("};\n")

print("static const char *cp437_to_utf8[] = {")
for i in range(0, 256):
    if i % 8 == 0:
        print("    ", end="")
    print('%14s, ' % f'"{repr(bytes([i]).decode("cp437").encode("utf-8"))[2:-1]}"', end="")
    if i % 8 == 7:
        print(f"// {hex(i - 7)}")
print("};\n")

print("static const char *cp1252_to_utf8[] = {")
for i in range(0, 256):
    if i % 8 == 0:
        print("    ", end="")
    print('%14s, ' % f'"{repr(bytes([i]).decode("cp1252", errors="replace").encode("utf-8"))[2:-1]}"', end="")
    if i % 8 == 7:
        print(f"// {hex(i - 7)}")
print("};\n")

print("static const char *cp866_to_utf8[] = {")
for i in range(0, 256):
    if i % 8 == 0:
        print("    ", end="")
    print('%14s, ' % f'"{repr(bytes([i]).decode("cp866").encode("utf-8"))[2:-1]}"', end="")
    if i % 8 == 7:
        print(f"// {hex(i - 7)}")
print("};\n")
