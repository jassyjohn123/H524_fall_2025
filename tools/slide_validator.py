#!/usr/bin/env python3
"""
Slide Validation Tool for H524 Biostatistics Course
Checks LaTeX Beamer slides for content overflow and formatting issues
"""

import re
import sys
from pathlib import Path

def count_items_in_frame(frame_content):
    """Count number of items in itemize/enumerate environments"""
    item_count = len(re.findall(r'\\item\b', frame_content))
    return item_count

def estimate_frame_content_length(frame_content):
    """Estimate content length by counting lines and characters"""
    # Remove LaTeX commands for rough estimate
    text = re.sub(r'\\[a-zA-Z]+(\{[^}]*\}|\[[^\]]*\])*', '', frame_content)
    text = re.sub(r'%.*$', '', text, flags=re.MULTILINE)  # Remove comments
    lines = [line.strip() for line in text.split('\n') if line.strip()]
    return len(lines), len(text)

def check_code_blocks(frame_content):
    """Check for large code blocks that might overflow"""
    code_blocks = re.findall(r'\\begin\{verbatim\}(.*?)\\end\{verbatim\}',
                              frame_content, re.DOTALL)
    code_blocks += re.findall(r'\\begin\{lstlisting\}(.*?)\\end\{lstlisting\}',
                               frame_content, re.DOTALL)

    max_lines = 0
    for block in code_blocks:
        lines = len(block.strip().split('\n'))
        max_lines = max(max_lines, lines)

    return len(code_blocks), max_lines

def extract_frames(tex_content):
    """Extract all frames from a Beamer document"""
    # Find all \begin{frame}...\end{frame} blocks
    pattern = r'\\begin\{frame\}(?:\[[^\]]*\])?(?:\{[^}]*\})?(.*?)\\end\{frame\}'
    frames = re.findall(pattern, tex_content, re.DOTALL)
    return frames

def validate_slide_file(tex_file_path):
    """Validate a single LaTeX slide file"""
    print(f"\n{'='*70}")
    print(f"Validating: {tex_file_path}")
    print(f"{'='*70}")

    with open(tex_file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    frames = extract_frames(content)
    print(f"\nTotal frames found: {len(frames)}")

    issues_found = False
    warnings = []

    for i, frame in enumerate(frames, 1):
        frame_issues = []

        # Check item count
        item_count = count_items_in_frame(frame)
        if item_count > 8:
            frame_issues.append(f"  - High item count: {item_count} items (recommend ≤8)")
            issues_found = True

        # Check content length
        line_count, char_count = estimate_frame_content_length(frame)
        if line_count > 25:
            frame_issues.append(f"  - Many lines: {line_count} lines (recommend ≤25)")
            issues_found = True
        if char_count > 1000:
            frame_issues.append(f"  - Long content: {char_count} chars (recommend ≤1000)")
            issues_found = True

        # Check code blocks
        num_blocks, max_code_lines = check_code_blocks(frame)
        if max_code_lines > 20:
            frame_issues.append(f"  - Large code block: {max_code_lines} lines (recommend ≤20)")
            issues_found = True

        if frame_issues:
            warnings.append(f"\nFrame {i}:")
            warnings.extend(frame_issues)

    if warnings:
        print("\n⚠️  POTENTIAL ISSUES FOUND:\n")
        for warning in warnings:
            print(warning)
    else:
        print("\n✅ No major issues detected!")

    return not issues_found

def main():
    if len(sys.argv) < 2:
        print("Usage: python slide_validator.py <tex_file>")
        print("Example: python slide_validator.py ../Week_4/slides/week4_slides.tex")
        sys.exit(1)

    tex_file = Path(sys.argv[1])

    if not tex_file.exists():
        print(f"Error: File not found: {tex_file}")
        sys.exit(1)

    if not tex_file.suffix == '.tex':
        print(f"Error: Not a .tex file: {tex_file}")
        sys.exit(1)

    success = validate_slide_file(tex_file)
    sys.exit(0 if success else 1)

if __name__ == "__main__":
    main()
