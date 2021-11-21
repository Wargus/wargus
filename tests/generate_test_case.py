import argparse
import pathlib
import sys
import hashlib

parser = argparse.ArgumentParser(
    description="Python script to generate testcase data for testing wartool."
)
parser.add_argument(
    "original_data_dir",
    type=pathlib.Path,
    help="The path to the directory with the original data files.",
)
parser.add_argument(
    "previous_wartool_output_dir",
    type=pathlib.Path,
    help="The path to the directory where wartool has previously output files.",
)
parser.add_argument("short_description", help="Short name used for the installer file.")


def get_file_list_from_root_dir(directory):
    list_out = []
    for file in directory.iterdir():
        if file.is_dir():
            list_out.extend(get_file_list_from_root_dir(file))
        else:
            list_out.append(file)
    list_out.sort()
    return list_out


def hash_dir(directory):
    h = hashlib.blake2b(digest_size=32)
    list_of_files = get_file_list_from_root_dir(directory)
    for file in list_of_files:
        with open(file, "rb") as f:
            h.update(f.read())
    return h.hexdigest()


def generate_test_case(original_directory, directory, desc):
    original_directory_hash = hash_dir(original_directory)
    output_file_list = get_file_list_from_root_dir(directory)
    with open(desc+'.testcase', "w") as out_file:
        out_file.write(original_directory_hash + "\n")
        out_file.write("Found " + str(len(output_file_list)) + " files.\n")
        for item in output_file_list:
            out_file.write(item.relative_to(directory).name + " ")
            h = hashlib.blake2b(digest_size=20)
            with open(item, "rb") as temp_file:
                h.update(temp_file.read())
            out_file.write(h.hexdigest())
            out_file.write("\n")


def main():
    args = parser.parse_args()
    generate_test_case(
        args.original_data_dir, args.previous_wartool_output_dir, args.short_description
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
