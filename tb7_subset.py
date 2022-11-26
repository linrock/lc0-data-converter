import itertools

SCORES = { 'Q': 9, 'R': 5, 'N': 3, 'B': 3, 'P': 1 }
MAX_SCORE_DIFF = 1

def piece_combos_with_scores(n):
    scored_combos = []
    for combo in list(set(
        [''.join(sorted(c, key=lambda p: -SCORES[p])) for c in itertools.product(SCORES.keys(), repeat=n)]
    )):
        scored_combos.append((combo, sum([SCORES[p] for p in combo])))
    return scored_combos

def find_combos_with_max_score_diff():
    for pc3 in piece_combos_with_scores(2):
        for pc4 in piece_combos_with_scores(3):
            if abs(pc4[1] - pc3[1]) <= MAX_SCORE_DIFF:
                print(pc4, pc3)

find_combos_with_max_score_diff()
