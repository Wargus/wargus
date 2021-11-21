import argparse
import pathlib
import sys
import hashlib
import generate_test_case

parser = argparse.ArgumentParser(
    description="Python script to test wartool."
)
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


def find_test_case(dir_hash):
    cur_path = pathlib.Path(".")
    for file in cur_path.iterdir():
        if not file.is_dir() and file.suffix == '.testcase':
            with open(file,'r') as temp:
                first=temp.readline()
                if first.strip() == dir_hash.strip():
                    return file
    return None
            

def run_test(original_data, new_output):
    original_directory_hash = generate_test_case.hash_dir(original_data)
    test_case = find_test_case(original_directory_hash)
    if test_case == None:
        print("Could not find an existing test case, please generate a test case first, then run this again.")
        sys.exit(-1)
    print("Running test case: " + test_case.name)
    file_count = -1
    file_hash_mapping = dict()
    with open(test_case,'r') as test_file:
        _hash = test_file.readline()
        file_count = int(test_file.readline().strip().split()[1])
        print("Expecting " + str(file_count) + " files")
        for line in test_file.readlines():
            if line.strip()=="":
                continue
            sections = line.strip().split()
            file_hash = sections[-1]
            file_name = ' '.join(sections[:-1])
            file_hash_mapping[file_name] = file_hash
    print(file_hash_mapping)


def main():
    args = parser.parse_args()
    run_test(
        args.original_data_dir, args.wartool_output_dir
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())




