#!/usr/bin/env python3
"""
Check LaTeX files for math symbols that should be in math mode
"""

import re
from pathlib import Path

def check_math_mode(tex_file):
    """Check for math symbols outside of math mode"""
    issues = []

    with open(tex_file, 'r', encoding='utf-8') as f:
        lines = f.readlines()

    # Patterns to check
    patterns = [
        # Unicode mathematical symbols that should use LaTeX commands
        (r'≤', r'should use $\\leq$ or \\leq in math mode'),
        (r'≥', r'should use $\\geq$ or \\geq in math mode'),
        (r'≠', r'should use $\\neq$ or \\neq in math mode'),
        (r'×', r'should use $\\times$ in math mode'),
        (r'÷', r'should use $\\div$ in math mode'),
        (r'±', r'should use $\\pm$ in math mode'),

        # Greek letters outside math mode (checking for raw Unicode)
        (r'(?<!\$)α(?!\$)', r'Greek alpha should be in math mode: $\\alpha$'),
        (r'(?<!\$)β(?!\$)', r'Greek beta should be in math mode: $\\beta$'),
        (r'(?<!\$)μ(?!\$)', r'Greek mu should be in math mode: $\\mu$'),
        (r'(?<!\$)σ(?!\$)', r'Greek sigma should be in math mode: $\\sigma$'),

        # Subscripted Unicode that should use LaTeX subscripts
        (r'H₀', r'should use $H_0$ in math mode'),
        (r'H₁', r'should use $H_1$ or $H_A$ in math mode'),
        (r'Hₐ', r'should use $H_A$ in math mode'),
        (r'μ₀', r'should use $\\mu_0$ in math mode'),
        (r'σ²', r'should use $\\sigma^2$ in math mode'),
    ]

    for line_num, line in enumerate(lines, 1):
        # Skip lines that are comments
        if line.strip().startswith('%'):
            continue

        # Skip lines inside math mode entirely (rough check)
        # This is a simplified check - may have false positives/negatives

        for pattern, message in patterns:
            matches = re.finditer(pattern, line)
            for match in matches:
                # Check if this is inside a math environment
                # Simple heuristic: count $ before this position
                before = line[:match.start()]
                dollar_count = before.count('$')

                # If odd number of $, we're likely inside inline math
                if dollar_count % 2 == 0:  # Even = outside math mode
                    issues.append({
                        'line': line_num,
                        'text': match.group(),
                        'message': message,
                        'context': line.strip()
                    })

    return issues

def main():
    base_dir = Path("/Users/molitorj/ms/OSU/classes/AI_H524/H524_fall_2025/Week_5")

    files_to_check = [
        base_dir / "slides" / "week5_slides.tex",
        base_dir / "Lab" / "week5_lab_KEY.tex",
        base_dir / "worksheets" / "week5_hypothesis_testing_worksheet_KEY.tex",
        base_dir / "assignments" / "week5_assignment.tex",
        base_dir / "assignments" / "week5_assignment_answer_key.tex",
    ]

    print("="*80)
    print("CHECKING MATH MODE USAGE IN WEEK 5 LATEX FILES")
    print("="*80)
    print()

    total_issues = 0

    for tex_file in files_to_check:
        if not tex_file.exists():
            continue

        issues = check_math_mode(tex_file)

        if issues:
            print(f"\n📄 {tex_file.name}")
            print(f"   Found {len(issues)} potential issues:")
            print()

            for issue in issues[:10]:  # Show first 10
                print(f"   Line {issue['line']}: '{issue['text']}' - {issue['message']}")

            if len(issues) > 10:
                print(f"   ... and {len(issues) - 10} more")

            total_issues += len(issues)
        else:
            print(f"\n✅ {tex_file.name}: No issues found")

    print()
    print("="*80)
    print(f"SUMMARY: {total_issues} total potential issues")
    print("="*80)

    if total_issues == 0:
        print("\n✅ All math symbols appear to be properly in math mode!")
    else:
        print(f"\n⚠️  Found {total_issues} symbols that may need to be converted to LaTeX math mode")

if __name__ == "__main__":
    main()
