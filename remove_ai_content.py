#!/usr/bin/env python3
"""
Script to remove AI-related content from H524 course materials.
Removes AI color definitions and entire AI sections from slide files.
"""

import re
import sys
from pathlib import Path

def remove_ai_colors(content):
    """Remove AI color definitions from LaTeX preamble."""
    # Pattern to match AI color definitions
    pattern = r'% Define custom colors for AI slides.*?% Define OSU orange color'
    replacement = '% Define OSU orange color'
    content = re.sub(pattern, replacement, content, flags=re.DOTALL)
    return content

def remove_ai_section(content, section_title_pattern):
    """Remove entire AI section from slides."""
    # Find the AI section start
    section_pattern = rf'\\section\{{{section_title_pattern}\}}.*?(?=\\section\{{|\\end\{{document\}})'

    # Remove everything from \section{AI...} to the next \section or \end{document}
    # Also remove \AIcolors and \defaultcolors commands
    content = re.sub(section_pattern, '', content, flags=re.DOTALL)

    return content

def process_slide_file(filepath):
    """Process a single slide file to remove AI content."""
    print(f"Processing {filepath}...")

    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    original_length = len(content)

    # Remove AI color definitions
    content = remove_ai_colors(content)

    # Remove AI sections (various titles)
    ai_section_patterns = [
        "AI as a Learning Tool.*?",
        "AI-Enhanced Learning.*?",
        "AI for Statistical Communication"
    ]

    for pattern in ai_section_patterns:
        content = remove_ai_section(content, pattern)

    # Write back
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)

    removed = original_length - len(content)
    print(f"  Removed {removed} characters from {filepath.name}")

    return removed > 0

def main():
    base_path = Path("/Users/molitorj/ms/OSU/classes/AI_H524/H524_fall_2025")

    slide_files = [
        base_path / "Week_3/slides/week3_slides.tex",
        base_path / "Week_6/slides/week6_slides.tex",
        base_path / "Week_7/slides/week7_slides.tex",
        base_path / "Week_8/slides/week8_slides.tex",
        base_path / "Week_9/slides/week9_slides.tex",
        base_path / "Week_10/slides/week10_slides.tex",
    ]

    modified_count = 0
    for filepath in slide_files:
        if filepath.exists():
            if process_slide_file(filepath):
                modified_count += 1
        else:
            print(f"Warning: {filepath} not found")

    print(f"\n=== Summary ===")
    print(f"Modified {modified_count} out of {len(slide_files)} files")
    print("\nNote: Week 1 and Week 2 were already processed manually.")

if __name__ == "__main__":
    main()
