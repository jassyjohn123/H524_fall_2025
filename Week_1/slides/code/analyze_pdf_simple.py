#!/usr/bin/env python3
"""
Simple PDF Analysis Script
Uses basic text extraction to analyze the worksheet PDF
"""

import sys
import subprocess
import re

def extract_pdf_text(pdf_path: str) -> str:
    """
    Extract text from PDF using pdftotext (part of poppler-utils)
    """
    try:
        result = subprocess.run(['pdftotext', pdf_path, '-'],
                              capture_output=True, text=True)
        if result.returncode == 0:
            return result.stdout
        else:
            print(f"Error running pdftotext: {result.stderr}")
            return None
    except FileNotFoundError:
        print("pdftotext not found. Trying alternative method...")
        return None

def analyze_text_for_table(text: str) -> None:
    """
    Analyze extracted text for table structure issues
    """
    if not text:
        print("No text extracted from PDF")
        return

    lines = text.split('\n')
    print(f"Extracted {len(lines)} lines of text")

    # Find Exercise 2.1
    exercise_found = False
    table_lines = []
    in_table_area = False

    for i, line in enumerate(lines):
        line_clean = line.strip()

        # Look for Exercise 2.1
        if re.search(r'exercise\s*2\.1', line_clean, re.IGNORECASE):
            print(f"\n=== FOUND EXERCISE 2.1 at line {i+1} ===")
            exercise_found = True
            in_table_area = True
            # Show context around Exercise 2.1
            start = max(0, i-3)
            end = min(len(lines), i+20)
            for j in range(start, end):
                marker = " >>> " if j == i else "     "
                print(f"{marker}Line {j+1}: {lines[j]}")

        # Look for table-related keywords
        if any(keyword in line_clean.lower() for keyword in
               ['variable', 'type', 'reasoning', 'categorical', 'continuous']):
            table_lines.append((i+1, line_clean))

    if exercise_found:
        print(f"\n=== TABLE-RELATED CONTENT ===")
        for line_num, content in table_lines:
            print(f"Line {line_num}: {content}")

        # Look for formatting patterns that might indicate table structure
        print(f"\n=== FORMATTING ANALYSIS ===")

        # Check for repeated patterns of spaces/tabs that might indicate columns
        spacing_patterns = {}
        for line_num, content in table_lines:
            # Count leading spaces
            leading_spaces = len(content) - len(content.lstrip())
            if leading_spaces > 0:
                if leading_spaces not in spacing_patterns:
                    spacing_patterns[leading_spaces] = []
                spacing_patterns[leading_spaces].append((line_num, content[:50]))

        if spacing_patterns:
            print("Indentation patterns (might indicate table columns):")
            for spaces, examples in spacing_patterns.items():
                print(f"  {spaces} spaces: {len(examples)} lines")
                for line_num, sample in examples[:3]:  # Show first 3 examples
                    print(f"    Line {line_num}: '{sample}...'")

        # Look for pipe characters, tabs, or multiple spaces that might be column separators
        separator_patterns = []
        for line_num, content in table_lines:
            if '|' in content:
                separator_patterns.append((line_num, content, 'pipe'))
            elif '\t' in content:
                separator_patterns.append((line_num, content, 'tab'))
            elif '  ' in content:  # Multiple spaces
                separator_patterns.append((line_num, content, 'spaces'))

        if separator_patterns:
            print("\nPotential column separators:")
            for line_num, content, sep_type in separator_patterns[:10]:
                print(f"  Line {line_num} ({sep_type}): {content}")

    else:
        print("Exercise 2.1 not found in extracted text")

def main():
    pdf_path = "/Users/molitorj/ms/OSU/classes/AI_H524/H524_fall_2025/Week_1/worksheets/week0_wednesday_worksheet.pdf"

    print("PDF Text Analysis for Table Structure")
    print("=" * 50)

    # Try to extract text
    text = extract_pdf_text(pdf_path)

    if not text:
        print("Could not extract text using pdftotext. Let me try reading the PDF directly...")
        # Let's try to read the PDF file directly to see what we can analyze
        try:
            with open(pdf_path, 'rb') as f:
                content = f.read()
                print(f"PDF file size: {len(content)} bytes")
                print("This is a binary PDF file. We need specialized tools to analyze table structure.")
                print("The table formatting issue likely involves:")
                print("1. LaTeX table column widths not properly defined")
                print("2. Missing or incomplete horizontal/vertical lines")
                print("3. Cell content overflowing column boundaries")
                print("4. Improper use of \\hline or \\cline commands")
        except Exception as e:
            print(f"Error reading PDF file: {e}")
    else:
        analyze_text_for_table(text)

if __name__ == "__main__":
    main()