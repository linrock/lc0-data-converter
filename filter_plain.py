import os.path
import sys

''' Filters out all chess positions with castling rights. Not
    ideal, just a quick way to remove Chess 960 positions with
    castling rights, which can't be used for training.
'''
if len(sys.argv) != 2:
    print('Usage: ./filter_plain.py <input.plain>')
    sys.exit(0)

input_filename = sys.argv[1]
output_filename = input_filename.replace('.plain', '.filtered.plain')

if os.path.isfile(output_filename):
    print(f'Found filtered file. Doing nothing: {output_filename}')
    sys.exit(0)

position = None
num_positions = 0
num_no_castling_positions = 0

print(f'Filtering {input_filename} ...')
with open(input_filename, 'r') as fin, open(output_filename, 'w+') as fout:
    for row in fin:
        if 'fen' in row:
            position = row
        else:
            position += row
        if row == 'e\n':
            num_positions += 1
            castle_flag = position.split()[3]
            if castle_flag == '-':
                num_no_castling_positions += 1
                fout.write(position)
print(f'Filtered {input_filename}')
print(f'  # positions before: {num_positions}')
print(f'  # positions after:  {num_no_castling_positions}')
