import itertools
import re
import sys

tb7_file_list = [
    '4v3_pawnful.html',
    '4v3_pawnless.html',
    '5v2_pawnful.html',
    '5v2_pawnless.html',
    '6v1_pawnful.html',
    '6v1_pawnless.html',
]

SCORES = { 'Q': 9, 'R': 5, 'B': 3.5, 'N': 3.25, 'P': 1 }

max_score_diff = 9999
if len(sys.argv) == 2:
    max_score_diff = float(sys.argv[1])


def piece_combos_with_scores(n):
    for combo in list(set([
        ''.join(sorted(c, key=lambda p: -SCORES[p]))
            for c in itertools.product(SCORES.keys(), repeat=n)
    ])):
        yield (combo, sum([SCORES[p] for p in combo]))

def combos_with_max_score_diff(max_score_diff):
    for pc3 in piece_combos_with_scores(2):
        for pc4 in piece_combos_with_scores(3):
            if abs(pc4[1] - pc3[1]) <= max_score_diff:
                yield((pc4, pc3))
    for pc3 in piece_combos_with_scores(1):
        for pc4 in piece_combos_with_scores(4):
            if abs(pc4[1] - pc3[1]) <= max_score_diff:
                yield((pc4, pc3))
    for pc3 in piece_combos_with_scores(0):
        for pc4 in piece_combos_with_scores(5):
            if abs(pc4[1] - pc3[1]) <= max_score_diff:
                yield((pc4, pc3))

def tb_filenames_with_max_score_diff(max_score_diff):
    for combos in combos_with_max_score_diff(max_score_diff):
        tb7p = 'v'.join(['K'+c[0] for c in combos])
        yield(tb7p)

tb7_data_sizes = {}
total_data_size_bytes = 0
subsets = list(tb_filenames_with_max_score_diff(max_score_diff))

for tb7_file in tb7_file_list:
    with open(tb7_file, 'r') as f:
        for row in f:
            tb_file_match = re.search('>(K[QRBNP]+vK[QRBNP]*\.rtb[wz])<', row)
            if tb_file_match:
                tb_filename = tb_file_match.group(1)
                if not tb_filename.split('.')[0] in subsets:
                    continue
                if 'BBB' in tb_filename or 'NNN' in tb_filename or 'RRR' in tb_filename:
                    continue
                tb_filesize = int(row.split()[-1])
                tb7_data_sizes[tb_filename] = tb_filesize
                total_data_size_bytes += tb_filesize
                # print(tb_filename, tb_filesize)
                print(tb_filename)

total_data_size_gb = round(total_data_size_bytes / 1024 / 1024 / 1024)
print()
print(f'Total data size: {total_data_size_gb} GB')
