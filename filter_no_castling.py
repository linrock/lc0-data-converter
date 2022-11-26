import os.path
import sys

''' Filters out non-standard chess positions (ie. chess960). Removing all
    positions with castling flags is not ideal, just a quick way.
'''
if len(sys.argv) != 3:
    print('Usage: ./filter_no_castling.py <input.plain> <output.plain>')
    sys.exit(0)

input_file = sys.argv[1]
output_file = input_file.replace('.plain', '.filtered.plain')

if os.path.isfile(output_file):
    print(f'Found filtered file. Doing nothing: {output_file}')
    sys.exit(0)

position = None
num_positions = 0
num_no_castling_positions = 0

print(f'Filtering {input_file} ...')
with open(output_file, 'w+') as fout:
    with open(input_file, 'r') as fin:
        for row in fin:
            if 'fen' in row:
                position = row
            else:
                position += row
            if row == 'e\n':
                num_positions += 1
                castle_flag = position.split()[3]
                if castle_flag == '-':
                    # no castling moves
                    num_no_castling_positions += 1
                    fout.write(position)
print(f'Filtered {input_file}')
print(f'  # positions before: {num_positions}')
print(f'  # positions after:  {num_no_castling_positions}')
