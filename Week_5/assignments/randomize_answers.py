#!/usr/bin/env python3
"""
Generate a completely random answer sequence for Week 5 quiz
with no detectable patterns.
"""

import random
import sys

def check_pattern(sequence):
    """Check for consecutive runs of same letter or alphabetical patterns"""
    # Check for 3+ consecutive same letters
    for i in range(len(sequence) - 2):
        if sequence[i] == sequence[i+1] == sequence[i+2]:
            return True, "Three consecutive same letters"

    # Check for alphabetical runs (A-B-C-D or D-C-B-A)
    for i in range(len(sequence) - 3):
        chunk = sequence[i:i+4]
        letters = ['A', 'B', 'C', 'D']
        if chunk == letters or chunk == letters[::-1]:
            return True, "Alphabetical run detected"

    # Check for alternating patterns (A-B-A-B or similar)
    for i in range(len(sequence) - 3):
        if sequence[i] == sequence[i+2] and sequence[i+1] == sequence[i+3]:
            # Only flag if it continues for 4+ elements
            if i+4 < len(sequence) and sequence[i] == sequence[i+4]:
                return True, "Alternating pattern"

    return False, "No pattern detected"

def generate_random_sequence(n_questions=13):
    """Generate random sequence with balanced distribution"""
    # We need 13 answers, aim for 3-4 of each letter
    # Target: A=3, B=4, C=3, D=3 (total=13)
    letters = ['A'] * 3 + ['B'] * 4 + ['C'] * 3 + ['D'] * 3

    max_attempts = 10000
    for attempt in range(max_attempts):
        random.shuffle(letters)
        has_pattern, msg = check_pattern(letters)
        if not has_pattern:
            return letters, attempt + 1

    return None, max_attempts

def count_distribution(sequence):
    """Count how many of each letter"""
    from collections import Counter
    return Counter(sequence)

if __name__ == "__main__":
    print("="*60)
    print("GENERATING RANDOM ANSWER SEQUENCE")
    print("="*60)

    # Current sequence (with pattern)
    current = ['A', 'C', 'B', 'A', 'D', 'C', 'B', 'A', 'D', 'C', 'B', 'D', 'A']
    print(f"\nCurrent sequence: {', '.join(current)}")
    print(f"Current distribution: {dict(count_distribution(current))}")
    has_pattern, msg = check_pattern(current)
    print(f"Pattern check: {msg}")

    # Generate new sequence
    print("\nGenerating new sequence...")
    new_sequence, attempts = generate_random_sequence(13)

    if new_sequence:
        print(f"\n{'='*60}")
        print("NEW RANDOM SEQUENCE (attempt #{})".format(attempts))
        print('='*60)
        print(f"Sequence: {', '.join(new_sequence)}")
        print(f"Distribution: {dict(count_distribution(new_sequence))}")
        has_pattern, msg = check_pattern(new_sequence)
        print(f"Pattern check: {msg}")

        # Print mapping
        print("\n" + "="*60)
        print("QUESTION-BY-QUESTION MAPPING")
        print("="*60)
        questions = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 13, 14, 15]
        print(f"{'Question':<10} {'Old Answer':<12} {'New Answer':<12}")
        print("-"*60)
        for i, q in enumerate(questions):
            print(f"Q{q:<9} {current[i]:<12} {new_sequence[i]:<12}")

        sys.exit(0)
    else:
        print("ERROR: Could not generate pattern-free sequence after many attempts")
        sys.exit(1)
