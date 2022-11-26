import sys

if len(sys.argv) != 3:
    print('Usage: ./filter_no_castling.py <input.plain> <output.plain>')
    sys.exit(0)

input_file = sys.argv[1]
output_file = sys.argv[2]

position = None
num_positions = 0
num_no_castling_positions = 0

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
print(f'# positions:    {num_positions}')
print(f'# no castling:  {num_no_castling_positions}')
