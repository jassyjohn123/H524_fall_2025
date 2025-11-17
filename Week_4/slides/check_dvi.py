#!/usr/bin/env python3
"""
Check DVI file for overfull boxes and page dimensions
"""

import subprocess
import re
import sys
import glob
import os

def check_dvi_overfull(tex_file=None):
    """Compile to DVI and extract overfull box information"""

    # Auto-detect .tex file if not specified
    if tex_file is None:
        tex_files = glob.glob("*.tex")
        if not tex_files:
            print("Error: No .tex files found in current directory")
            sys.exit(1)
        elif len(tex_files) == 1:
            tex_file = tex_files[0]
            print(f"Auto-detected: {tex_file}\n")
        else:
            print("Multiple .tex files found. Please specify which one:")
            for i, f in enumerate(tex_files, 1):
                print(f"  {i}. {f}")
            print(f"\nUsage: python3 check_dvi.py <filename.tex>")
            sys.exit(1)

    # Verify file exists
    if not os.path.exists(tex_file):
        print(f"Error: File '{tex_file}' not found")
        sys.exit(1)

    print(f"Checking: {tex_file}\n")

    # Compile to DVI
    result = subprocess.run(
        ['latex', '-interaction=nonstopmode', tex_file],
        capture_output=True,
        text=True
    )

    # Parse overfull boxes
    overfull_pattern = r'Overfull \\vbox \(([0-9.]+)pt too high\) detected at line (\d+)'

    overfull_boxes = []
    for match in re.finditer(overfull_pattern, result.stdout):
        pts = float(match.group(1))
        line = int(match.group(2))
        overfull_boxes.append((pts, line))

    # Sort by severity
    overfull_boxes.sort(reverse=True)

    print(f"Total overfull vboxes: {len(overfull_boxes)}")
    print("\nTop 10 worst offenders:")
    print("-" * 50)
    for i, (pts, line) in enumerate(overfull_boxes[:10], 1):
        severity = "CRITICAL" if pts > 15 else "HIGH" if pts > 10 else "MEDIUM" if pts > 5 else "LOW"
        print(f"{i:2d}. Line {line:4d}: {pts:6.2f}pt too high [{severity}]")

    # Summary by severity
    critical = sum(1 for pts, _ in overfull_boxes if pts > 15)
    high = sum(1 for pts, _ in overfull_boxes if 10 < pts <= 15)
    medium = sum(1 for pts, _ in overfull_boxes if 5 < pts <= 10)
    low = sum(1 for pts, _ in overfull_boxes if pts <= 5)

    print("\n" + "=" * 50)
    print("Summary by Severity:")
    print(f"  CRITICAL (>15pt):  {critical}")
    print(f"  HIGH (10-15pt):    {high}")
    print(f"  MEDIUM (5-10pt):   {medium}")
    print(f"  LOW (<=5pt):       {low}")
    print("=" * 50)

    if critical + high == 0:
        print("\n✓ SUCCESS: All major issues resolved!")
        print("  (Only minor overfull boxes <10pt remaining)")
    else:
        print(f"\n⚠ WARNING: {critical + high} slides still need attention")

    return overfull_boxes

if __name__ == "__main__":
    # Get filename from command line argument if provided
    tex_file = sys.argv[1] if len(sys.argv) > 1 else None
    check_dvi_overfull(tex_file)
