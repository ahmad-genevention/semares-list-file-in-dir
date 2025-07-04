import os
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('-i', '--input_folder', required=True)
parser.add_argument('-n', '--name', required=True)
parser.add_argument('-o', '--output', required=True)

args = parser.parse_args()

with open(args.output, 'w') as f:
    f.write(f"Hello {args.name},\n")
    f.write("following are the files in provided dataset directory:\n")
    for root, _, files in os.walk(args.input_folder):
        for file in files:
            f.write(f"{os.path.join(root, file)}\n")
    print('file writing is done.')
