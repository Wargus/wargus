import argparse
import pathlib
import sys

parser = argparse.ArgumentParser(description='Python script to generate testcase data for testing wartool.')
parser.add_argument('previous_wartool_output_dir', type=pathlib.Path,
                    help='The path to the directory where wartool has previously output files.')
parser.add_argument('short_description',
                    help='Short name used for the installer file.')


def generate_test_case(directory, desc):
    pass


def main() -> int:
    args = parser.parse_args()
    generate_test_case(args.previous_wartool_output_dir, args.short_description)
    return 0

if __name__ == '__main__':
    sys.exit(main())


