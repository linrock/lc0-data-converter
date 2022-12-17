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
num_filtered_positions = 0
num_non_standard_positions = 0
num_no_castling_flag_positions = 0

is_standard_game = False
num_standard_games = 0
num_non_standard_games = 0

print(f'Filtering {input_filename} ...')
with open(input_filename, 'r') as infile, open(output_filename, 'w+') as outfile:
    for row in infile:
        if 'fen' in row:
            position = row
            # assumes the input .plain file is a sequence of games
            if row.endswith('0 1\n') and ' w ' in row:
                # if starting positions
                if 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq' in row:
                    is_standard_game = True
                    num_standard_games += 1
                else:
                    is_standard_game = False
                    num_non_standard_games += 1
        else:
            position += row
        if row == 'e\n':
            num_positions += 1
            castle_flag = position.split()[3]
            if castle_flag == '-':
                # any position without castling rights is ok
                num_filtered_positions += 1
                num_no_castling_flag_positions += 1
                outfile.write(position)
            elif is_standard_game:
                # positions with castling rights in standard games is ok
                num_filtered_positions += 1
                outfile.write(position)
            else:
                # ignore positions with castling rights in non-standard games
                num_non_standard_positions += 1

print(f'Filtered {input_filename} to {output_filename}')
print(f'  # standard games:      {num_standard_games}')
print(f'  # non-standard games:  {num_non_standard_games}')
print(f'  # positions:           {num_positions}')
print(f'  # no-castling flags:   {num_no_castling_flag_positions}')
print(f'  # ignored positions:   {num_non_standard_positions}')
print(f'  # filtered positions:  {num_filtered_positions}')
