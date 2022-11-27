import re

tb7_file_list = [
    '4v3_pawnful.html',
    '4v3_pawnless.html',
    '5v2_pawnful.html',
    '5v2_pawnless.html',
    '6v1_pawnful.html',
    '6v1_pawnless.html',
]
tb7_data_sizes = {}

total_data_size_bytes = 0
for tb7_file in tb7_file_list:
    with open(tb7_file, 'r') as f:
        for row in f:
            tb_file_match = re.search('>(K[QRBNP]+vK[QRBNP]*\.rtb[wz])<', row)
            if tb_file_match:
                tb_filename = tb_file_match.group(1)
                tb_filesize = int(row.split()[-1])
                tb7_data_sizes[tb_filename] = tb_filesize
                total_data_size_bytes += tb_filesize
                print(tb_filename, tb_filesize)

total_data_size_gb = round(total_data_size_bytes / 1024 / 1024 / 1024)
print()
print(f'Total data size: {total_data_size_gb} GB')
