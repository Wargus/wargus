import argparse
import pathlib
import sys
import hashlib
import subprocess
import generate_test_case

parser = argparse.ArgumentParser(description="Python script to test wartool.")
parser.add_argument(
    "original_data_dir",
    type=pathlib.Path,
    help="The path to the directory with the original data files.",
)
parser.add_argument(
    "wartool_output_dir",
    type=pathlib.Path,
    help="The path to the directory where wartool should output the new files.",
)
parser.add_argument(
    "wartool_exe",
    type=pathlib.Path,
    help="The path to the version of wartool to test.",
)


def find_test_case(dir_hash):
    cur_path = pathlib.Path(".")
    for file in cur_path.iterdir():
        if not file.is_dir() and file.suffix == ".testcase":
            with open(file, "r") as temp:
                first = temp.readline()
                if first.strip() == dir_hash.strip():
                    return file
    return None


def run_test(original_data, new_output, executable):
    errors = False
    original_directory_hash = generate_test_case.hash_dir(original_data)
    test_case = find_test_case(original_directory_hash)
    if test_case == None:
        print(
            "Could not find an existing test case, please generate a test case first, then run this again."
        )
        sys.exit(-1)
    print("Running test case: " + test_case.name)
    file_count = -1
    file_hash_mapping = dict()
    with open(test_case, "r") as test_file:
        _hash = test_file.readline()
        file_count = int(test_file.readline().strip().split()[1])
        print("Expecting " + str(file_count) + " files")
        for line in test_file.readlines():
            if line.strip() == "":
                continue
            sections = line.strip().split()
            file_hash = sections[-1]
            file_name = " ".join(sections[:-1])
            file_hash_mapping[file_name] = file_hash
    s = subprocess.run([executable, original_data, new_output], capture_output=True)
    print(s.stderr.decode())
    print(s.stdout.decode())

    file_list = generate_test_case.get_file_list_from_root_dir(new_output)
    print("Found " + str(len(file_list)) + " files.\n")
    if len(file_list) != file_count:
        print(
            "Wrong number of files!\nExpected "
            + str(file_count)
            + " but found "
            + str(len(file_list))
        )
        errors = True
    new_file_hash_mapping = dict()
    for item in file_list:
        h = hashlib.blake2b(digest_size=20)
        with open(item, "rb") as temp_file:
            h.update(temp_file.read())
        new_file_hash_mapping[item.relative_to(new_output).name] = h.hexdigest()
    for key, value in new_file_hash_mapping.items():
        try:
            if file_hash_mapping[key] != value:
                print("Disagreement on file: " + key)
                errors = True
        except:
            print("Error checking file: " + key)
            errors = True
    print(set(new_file_hash_mapping) - set(file_hash_mapping))
    print(set(file_hash_mapping) - set(new_file_hash_mapping))
    if errors:
        sys.exit(3)


def main():
    args = parser.parse_args()
    run_test(args.original_data_dir, args.wartool_output_dir, args.wartool_exe)
    return 0


if __name__ == "__main__":
    sys.exit(main())
