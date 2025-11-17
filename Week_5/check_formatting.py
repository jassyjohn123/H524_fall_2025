#!/usr/bin/env python3
"""
Check Week 5 materials for formatting issues
Compiles to DVI and analyzes overfull/underfull boxes
"""

import subprocess
import os
import re
from pathlib import Path

def compile_to_dvi(tex_file):
    """Compile LaTeX file to DVI and capture warnings"""
    tex_path = Path(tex_file)
    if not tex_path.exists():
        return None, f"File not found: {tex_file}"

    # Change to directory containing tex file
    work_dir = tex_path.parent
    tex_name = tex_path.name

    # Compile with latex (not pdflatex) to get DVI
    cmd = ['latex', '-interaction=nonstopmode', tex_name]

    try:
        result = subprocess.run(
            cmd,
            cwd=work_dir,
            capture_output=True,
            text=True,
            timeout=60
        )
        return result.stdout + result.stderr, None
    except subprocess.TimeoutExpired:
        return None, "Compilation timeout"
    except Exception as e:
        return None, str(e)

def parse_overfull_boxes(log_output):
    """Parse overfull and underfull box warnings from LaTeX log"""
    overfull_pattern = re.compile(r'Overfull \\([hv])box \(([0-9.]+)pt too (wide|high)\)')
    underfull_pattern = re.compile(r'Underfull \\([hv])box \(badness ([0-9]+)\)')

    overfull_boxes = []
    underfull_boxes = []

    for line in log_output.split('\n'):
        overfull_match = overfull_pattern.search(line)
        if overfull_match:
            box_type = overfull_match.group(1)  # h or v
            amount = float(overfull_match.group(2))
            direction = overfull_match.group(3)  # wide or high
            overfull_boxes.append({
                'type': box_type,
                'amount': amount,
                'direction': direction,
                'line': line.strip()
            })

        underfull_match = underfull_pattern.search(line)
        if underfull_match:
            box_type = underfull_match.group(1)
            badness = int(underfull_match.group(2))
            underfull_boxes.append({
                'type': box_type,
                'badness': badness,
                'line': line.strip()
            })

    return overfull_boxes, underfull_boxes

def categorize_severity(amount):
    """Categorize overfull box severity"""
    if amount > 15:
        return "CRITICAL"
    elif amount > 10:
        return "HIGH"
    elif amount > 5:
        return "MEDIUM"
    else:
        return "LOW"

def check_file(tex_file):
    """Check a single TEX file for formatting issues"""
    print(f"\n{'='*80}")
    print(f"Checking: {tex_file}")
    print(f"{'='*80}")

    log_output, error = compile_to_dvi(tex_file)

    if error:
        print(f"ERROR: {error}")
        return

    overfull, underfull = parse_overfull_boxes(log_output)

    # Categorize overfull boxes
    critical = [box for box in overfull if categorize_severity(box['amount']) == "CRITICAL"]
    high = [box for box in overfull if categorize_severity(box['amount']) == "HIGH"]
    medium = [box for box in overfull if categorize_severity(box['amount']) == "MEDIUM"]
    low = [box for box in overfull if categorize_severity(box['amount']) == "LOW"]

    print(f"\n📊 OVERFULL BOX SUMMARY:")
    print(f"   CRITICAL (>15pt): {len(critical)}")
    print(f"   HIGH (10-15pt):   {len(high)}")
    print(f"   MEDIUM (5-10pt):  {len(medium)}")
    print(f"   LOW (≤5pt):       {len(low)}")
    print(f"   TOTAL:            {len(overfull)}")

    if critical:
        print(f"\n⚠️  CRITICAL ISSUES (>15pt):")
        for box in critical:
            print(f"   • {box['type']}box: {box['amount']:.2f}pt too {box['direction']}")

    if high:
        print(f"\n⚠️  HIGH PRIORITY (10-15pt):")
        for box in high:
            print(f"   • {box['type']}box: {box['amount']:.2f}pt too {box['direction']}")

    if medium:
        print(f"\n⚠️  MEDIUM PRIORITY (5-10pt):")
        for box in medium[:5]:  # Show first 5
            print(f"   • {box['type']}box: {box['amount']:.2f}pt too {box['direction']}")
        if len(medium) > 5:
            print(f"   ... and {len(medium)-5} more")

    print(f"\n📋 Underfull boxes: {len(underfull)}")

    # Overall status
    if critical:
        print(f"\n❌ STATUS: NEEDS FIXING (CRITICAL issues)")
    elif high:
        print(f"\n⚠️  STATUS: NEEDS ATTENTION (HIGH priority issues)")
    elif medium:
        print(f"\n⚠️  STATUS: ACCEPTABLE (only MEDIUM/LOW issues)")
    else:
        print(f"\n✅ STATUS: GOOD (no significant overfull boxes)")

    return {
        'critical': len(critical),
        'high': len(high),
        'medium': len(medium),
        'low': len(low),
        'total': len(overfull)
    }

def main():
    """Check all Week 5 materials"""
    base_dir = Path("/Users/molitorj/ms/OSU/classes/AI_H524/H524_fall_2025/Week_5")

    files_to_check = [
        base_dir / "slides" / "week5_slides.tex",
        base_dir / "Lab" / "week5_lab_KEY.tex",
        base_dir / "worksheets" / "week5_hypothesis_testing_worksheet_KEY.tex",
        base_dir / "assignments" / "week5_assignment.tex",
        base_dir / "assignments" / "week5_assignment_answer_key.tex",
    ]

    results = {}

    for tex_file in files_to_check:
        if tex_file.exists():
            result = check_file(str(tex_file))
            results[tex_file.name] = result
        else:
            print(f"\n⚠️  File not found: {tex_file}")

    # Summary
    print(f"\n\n{'='*80}")
    print(f"SUMMARY - Week 5 Formatting Check")
    print(f"{'='*80}\n")

    for filename, result in results.items():
        if result:
            status = "❌ CRITICAL" if result['critical'] > 0 else \
                     "⚠️  HIGH" if result['high'] > 0 else \
                     "⚠️  MEDIUM" if result['medium'] > 0 else \
                     "✅ GOOD"
            print(f"{status:12} {filename:50} Total: {result['total']:3d}")

if __name__ == "__main__":
    main()
