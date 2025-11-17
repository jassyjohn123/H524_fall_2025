#!/usr/bin/env python3
"""
Fix assignment numbering in QTI and TEX files.
Replace assignment text numbering with Canvas numbering or remove prefixes.
"""
import re
import shutil
from pathlib import Path

def fix_week1_qti():
    """Fix Week 1 QTI: Remove 'Question X:' prefixes from essay questions"""
    file_path = Path("Week_1/assignments/week1_canvas_quiz.xml")

    with open(file_path, 'r') as f:
        content = f.read()

    # Backup
    shutil.copy(file_path, str(file_path) + ".backup")

    # Remove "Question 11 (10 points):" → "Data Types Classification (10 points)"
    content = content.replace(
        "<p><strong>Question 11 (10 points): Data Types Classification</strong></p>",
        "<p><strong>Data Types Classification (10 points)</strong></p>"
    )

    content = content.replace(
        "<p><strong>Question 12 (10 points): Descriptive Statistics Analysis</strong></p>",
        "<p><strong>Descriptive Statistics Analysis (10 points)</strong></p>"
    )

    content = content.replace(
        "<p><strong>Question 13 (10 points): Choosing Appropriate Visualizations</strong></p>",
        "<p><strong>Choosing Appropriate Visualizations (10 points)</strong></p>"
    )

    content = content.replace(
        "<p><strong>Question 14 (15 points): R Data Analysis with FEV1 Dataset</strong></p>",
        "<p><strong>R Data Analysis with FEV1 Dataset (15 points)</strong></p>"
    )

    with open(file_path, 'w') as f:
        f.write(content)

    print("✓ Fixed Week 1 QTI")

def fix_week4_qti():
    """Fix Week 4 QTI: Change cross-references to use Canvas numbering"""
    file_path = Path("Week_4/assignments/week4_assignment_quiz.xml")

    with open(file_path, 'r') as f:
        content = f.read()

    # Backup
    shutil.copy(file_path, str(file_path) + ".backup")

    # "Question 5" is Canvas Q9 (Manual CI question)
    # "Question 8" is Canvas Q12 (Proportion calculation)

    content = content.replace(
        "Using the same data from Question 5,",
        "Using the same data from the Manual CI question (Canvas Q9),"
    )

    content = content.replace(
        "Using the data from Question 8 (p̂ = 0.75, n = 200)",
        "Using p̂ = 0.75 and n = 200 from the previous question"
    )

    with open(file_path, 'w') as f:
        f.write(content)

    print("✓ Fixed Week 4 QTI")

def fix_week5_qti():
    """Fix Week 5 QTI: Change cross-reference to use Canvas numbering"""
    file_path = Path("Week_5/assignments/week5_assignment_quiz.xml")

    with open(file_path, 'r') as f:
        content = f.read()

    # Backup
    shutil.copy(file_path, str(file_path) + ".backup")

    # "Question 5" is Canvas Q5 (T-statistic calculation)
    content = content.replace(
        "For the scenario in Question 5 (t = 1.25, df = 24, two-sided test)",
        "Given t = 1.25, df = 24, two-sided test"
    )

    with open(file_path, 'w') as f:
        f.write(content)

    print("✓ Fixed Week 5 QTI")

def fix_week4_tex():
    """Fix Week 4 TEX files: Update cross-references"""
    files = [
        Path("Week_4/assignments/week4_assignment_student.tex"),
        Path("Week_4/assignments/week4_assignment_with_answers.tex")
    ]

    for file_path in files:
        with open(file_path, 'r') as f:
            content = f.read()

        # Backup
        shutil.copy(file_path, str(file_path) + ".backup")

        content = content.replace(
            "Using the same data from Question 5,",
            "Using the same data from the Manual CI question above,"
        )

        content = content.replace(
            "Using the data from Question 8",
            "Using the data from the proportion calculation question"
        )

        with open(file_path, 'w') as f:
            f.write(content)

    print("✓ Fixed Week 4 TEX files")

def fix_week5_tex():
    """Fix Week 5 TEX file: Update cross-reference"""
    file_path = Path("Week_5/assignments/week5_assignment.tex")

    with open(file_path, 'r') as f:
        content = f.read()

    # Backup
    shutil.copy(file_path, str(file_path) + ".backup")

    content = content.replace(
        "For the scenario in Question 5",
        "Given the scenario with"
    )

    with open(file_path, 'w') as f:
        f.write(content)

    print("✓ Fixed Week 5 TEX")

# Main execution
if __name__ == "__main__":
    print("="*80)
    print("FIXING ASSIGNMENT NUMBERING IN QTI AND TEX FILES")
    print("="*80)
    print()

    fix_week1_qti()
    fix_week4_qti()
    fix_week5_qti()
    fix_week4_tex()
    fix_week5_tex()

    print()
    print("="*80)
    print("✅ ALL FILES FIXED!")
    print("="*80)
    print()
    print("Next steps:")
    print("1. Recompile Week 4 and 5 PDFs")
    print("2. Regenerate all QTI zip files")
