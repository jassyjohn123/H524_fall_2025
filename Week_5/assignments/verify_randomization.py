#!/usr/bin/env python3
"""
Verify the randomization was successful and no patterns exist.
"""

import re
from collections import Counter

def extract_correct_answers_from_xml(xml_path):
    """Extract correct answers from XML file"""
    with open(xml_path, 'r') as f:
        content = f.read()

    # Find all questions (exclude fill-in-the-blank Q11, Q12)
    correct_answers = {}

    # Questions we care about (multiple choice only)
    mc_questions = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 13, 14, 15]

    for q_num in mc_questions:
        # Find the varequal tag for this question
        pattern = rf'<item ident="q{q_num}".*?<varequal respident="response1">(.*?)</varequal>'
        match = re.search(pattern, content, re.DOTALL)
        if match:
            correct_answers[q_num] = match.group(1).strip()

    return correct_answers

def check_pattern(sequence):
    """Check for consecutive runs or alphabetical patterns"""
    issues = []

    # Check for 3+ consecutive same letters
    for i in range(len(sequence) - 2):
        if sequence[i] == sequence[i+1] == sequence[i+2]:
            issues.append(f"Three consecutive '{sequence[i]}' at positions {i+1}-{i+3}")

    # Check for alphabetical runs (A-B-C-D or D-C-B-A)
    for i in range(len(sequence) - 3):
        chunk = sequence[i:i+4]
        letters = ['a', 'b', 'c', 'd']
        if chunk == letters:
            issues.append(f"Forward alphabetical run at positions {i+1}-{i+4}: {chunk}")
        if chunk == letters[::-1]:
            issues.append(f"Reverse alphabetical run at positions {i+1}-{i+4}: {chunk}")

    # Check for problematic alternating patterns
    for i in range(len(sequence) - 5):
        if (sequence[i] == sequence[i+2] == sequence[i+4] and
            sequence[i+1] == sequence[i+3] == sequence[i+5]):
            issues.append(f"Alternating pattern at positions {i+1}-{i+6}")

    return issues

if __name__ == "__main__":
    xml_path = "week5_assignment_quiz.xml"

    print("="*70)
    print("ANSWER RANDOMIZATION VERIFICATION")
    print("="*70)

    # Extract answers from XML
    answers = extract_correct_answers_from_xml(xml_path)

    # Convert to sequence
    questions = sorted(answers.keys())
    sequence = [answers[q] for q in questions]

    print(f"\nNew answer sequence: {', '.join(sequence).upper()}")
    print(f"Question order: Q{', Q'.join(map(str, questions))}")

    # Check distribution
    distribution = Counter(sequence)
    print(f"\nDistribution:")
    for letter in ['a', 'b', 'c', 'd']:
        count = distribution.get(letter, 0)
        print(f"  {letter.upper()}: {count} questions")

    # Check for patterns
    print(f"\nPattern check:")
    issues = check_pattern(sequence)

    if issues:
        print("  ⚠️  PATTERNS DETECTED:")
        for issue in issues:
            print(f"    - {issue}")
    else:
        print("  ✓ No obvious patterns detected")

    # Check balance
    total = len(sequence)
    expected_per_letter = total / 4
    min_acceptable = int(expected_per_letter) - 1
    max_acceptable = int(expected_per_letter) + 1

    print(f"\nBalance check:")
    print(f"  Total questions: {total}")
    print(f"  Expected per letter: ~{expected_per_letter:.1f}")
    print(f"  Acceptable range: {min_acceptable}-{max_acceptable}")

    balanced = all(min_acceptable <= count <= max_acceptable
                   for count in distribution.values())

    if balanced:
        print("  ✓ Distribution is balanced")
    else:
        print("  ⚠️  Distribution may be unbalanced")

    # Overall assessment
    print(f"\n" + "="*70)
    if not issues and balanced:
        print("✓ RANDOMIZATION SUCCESSFUL - No patterns, balanced distribution")
    else:
        print("⚠️  REVIEW NEEDED - See issues above")
    print("="*70)
