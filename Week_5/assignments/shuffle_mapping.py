#!/usr/bin/env python3
"""
Create the shuffle mapping for each question.
Shows which option currently contains the correct answer and where it needs to move.
"""

# Current correct answers (where the correct answer currently is)
current_correct = {
    1: 'A',   # Currently correct answer is in position A
    2: 'C',   # Currently correct answer is in position C
    3: 'B',   # etc.
    4: 'A',
    5: 'D',
    6: 'C',
    7: 'B',
    8: 'A',
    9: 'D',
    10: 'C',
    13: 'B',
    14: 'D',
    15: 'A'
}

# New desired correct positions
new_correct = {
    1: 'D',
    2: 'C',
    3: 'C',
    4: 'B',
    5: 'A',
    6: 'A',
    7: 'C',
    8: 'B',
    9: 'D',
    10: 'B',
    13: 'B',
    14: 'A',
    15: 'D'
}

print("="*70)
print("SHUFFLE MAPPING FOR EACH QUESTION")
print("="*70)
print(f"\n{'Q#':<5} {'Current':<10} {'New':<10} {'Action':<50}")
print("-"*70)

for q in sorted(current_correct.keys()):
    curr = current_correct[q]
    new = new_correct[q]

    if curr == new:
        action = "✓ No change needed (already in correct position)"
    else:
        action = f"Move correct answer: {curr} → {new}"

    print(f"{q:<5} {curr:<10} {new:<10} {action:<50}")

print("\n" + "="*70)
print("SUMMARY")
print("="*70)
no_change = sum(1 for q in current_correct if current_correct[q] == new_correct[q])
need_change = len(current_correct) - no_change
print(f"Questions requiring shuffle: {need_change}")
print(f"Questions unchanged: {no_change}")
