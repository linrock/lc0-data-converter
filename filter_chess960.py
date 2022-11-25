# Given a file, filter out all positions with chess960 castling flags

position = None
num_positions = 0
num_standard_positions = 0
with open('out.plain', 'w') as fout:
    with open('tiny.plain', 'r') as fin:
        for row in fin:
            if 'fen' in row:
                position = row
            else:
                position += row
            if row == 'e\n':
                num_positions += 1
                castle_flag = position.split()[3]
                if castle_flag == '-' or all(c == 'k' or c == 'q' for c in castle_flag.lower()):
                    # standard chess position
                    num_standard_positions += 1
                    fout.write(position)
print(f'# positions:           {num_positions}')
print(f'# standard positions:  {num_standard_positions}')
