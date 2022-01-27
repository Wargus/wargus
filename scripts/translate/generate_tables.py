#!/usr/bin/env python3

from unidecode import unidecode


ESCAPE = bytes([ord('\\')])


def print_reverse_mapping_for_codepage(cp, start, end):
    print(f"static const unsigned char utf8_to_{cp}[] = {{")
    for i in range(start, end + 1):
        if i % 16 == 0:
            print("    ", end="")
        replacement = chr(i).encode(cp, errors="replace").replace(b'?', b'\x00')
        assert len(replacement) == 1
        print("0x%02x" % replacement[0], end="")
        if i != end:
            print(", ", end="")
        else:
            print("  ", end="")
        if i % 16 == 15:
            print(f"// {hex(i - 15)}")
    print("};\n")


print_reverse_mapping_for_codepage("cp437", 0xa0, 0xff)
print_reverse_mapping_for_codepage("cp1252", 0xa0, 0xff)
print_reverse_mapping_for_codepage("cp866", 0x400, 0x45f)


def print_ascii_mapping_for_range(start, end):
    print(f"static const char * utf8_from_{hex(start)}_to_ascii[] = {{")
    for i in range(start, end + 1):
        if i % 16 == 0:
            print("    ", end="")
        replacement = repr((unidecode(chr(i)) or "?").encode('ascii').replace(b'"', ESCAPE + b'"'))[2:-1].replace(r'\\', '\\')
        print("%8s, " % f'"{replacement}"', end="")
        if i % 16 == 15:
            print(f"// {hex(i - 15)}")
    print("};\n")


print_ascii_mapping_for_range(0xa0, 0xff)
print_ascii_mapping_for_range(0x400, 0x45f)


def print_mapping_to_utf(cp):
    print(f"static const char *{cp}_to_utf8[] = {{")
    for i in range(0, 256):
        if i % 8 == 0:
            print("    ", end="")
        replacement = bytes([i]).decode(cp, errors="replace").encode("utf-8").replace(b'"', ESCAPE + b'"')
        print('%14s, ' % f'"{repr(replacement)[2:-1]}"', end="")
        if i % 8 == 7:
            print(f"// {hex(i - 7)}")
    print("};\n")


print_mapping_to_utf("cp437")
print_mapping_to_utf("cp1252")
print_mapping_to_utf("cp866")
