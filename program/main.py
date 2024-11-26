from typing import List, Tuple
from itertools import combinations_with_replacement

sides = 4       # four-sided die
omega = 4 * 4   # size of sample space 

# compute P(X > Y)
def pairwise_probability(X: Tuple[int], Y: Tuple[int]) -> float:
    wins = sum(1 for x in X for y in Y if x > y)
    return wins / omega

# numbers 1 to 6 and 4 faces, all combos
def generate_dice():
    return list(combinations_with_replacement(range(1, 7), sides))


def find_max_p():
    print("Finding maximal p:")

    dice = generate_dice()
    max_p = 0
    inc = 1 / omega

    # iterate from 1..=16 incrementing by 1 / |Omega|
    for p in range(1, 17): 
        p *= inc
        print(f"Testing for p = {p}")
        valid = False
        for A in dice:
            for B in dice:
                for C in dice:
                    if (pairwise_probability(B, A) >= p and
                        pairwise_probability(C, B) >= p and
                        pairwise_probability(A, C) > p):
                        valid = True
                        break
                if valid:
                    break
            if valid:
                break
        if not valid:
            # return the last valid p
            print("  No valid configurations!")
            return max_p  
        print(f"  A = {A}, B = {B}, C = {C}")
        max_p = p


result = find_max_p()
print(f"Maximal p = {result}")

