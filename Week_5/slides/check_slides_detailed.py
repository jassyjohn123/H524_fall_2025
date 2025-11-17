#!/usr/bin/env python3
"""
Detailed slide formatting checker - identifies specific problematic frames
"""

import subprocess
import re
from pathlib import Path

def compile_and_analyze(tex_file):
    """Compile to DVI and get detailed overfull box information"""
    tex_path = Path(tex_file)

    # Compile with latex
    cmd = ['latex', '-interaction=nonstopmode', tex_path.name]
    result = subprocess.run(
        cmd,
        cwd=tex_path.parent,
        capture_output=True,
        text=True
    )

    log_output = result.stdout + result.stderr

    # Parse overfull boxes with context
    overfull_pattern = re.compile(r'Overfull \\([hv])box \(([0-9.]+)pt too (wide|high)\)(.*?)(?=\n\n|\nOverfull|\nUnderfull|$)', re.DOTALL)

    issues = []
    for match in overfull_pattern.finditer(log_output):
        box_type = match.group(1)
        amount = float(match.group(2))
        direction = match.group(3)
        context = match.group(4)

        # Try to extract frame title from context
        frame_match = re.search(r'\\frametitle\s*{([^}]+)}', context)
        frame_title = frame_match.group(1) if frame_match else "Unknown"

        # Try to extract line number
        line_match = re.search(r'lines? (\d+)', context)
        line_num = line_match.group(1) if line_match else "?"

        severity = "CRITICAL" if amount > 15 else \
                   "HIGH" if amount > 10 else \
                   "MEDIUM" if amount > 5 else "LOW"

        issues.append({
            'type': box_type,
            'amount': amount,
            'direction': direction,
            'severity': severity,
            'frame': frame_title,
            'line': line_num,
            'context': context[:200]
        })

    # Sort by severity then amount
    severity_order = {'CRITICAL': 0, 'HIGH': 1, 'MEDIUM': 2, 'LOW': 3}
    issues.sort(key=lambda x: (severity_order[x['severity']], -x['amount']))

    return issues

def main():
    tex_file = "week5_slides.tex"
    print(f"{'='*80}")
    print(f"DETAILED SLIDE FORMATTING ANALYSIS: {tex_file}")
    print(f"{'='*80}\n")

    issues = compile_and_analyze(tex_file)

    # Group by severity
    critical = [i for i in issues if i['severity'] == 'CRITICAL']
    high = [i for i in issues if i['severity'] == 'HIGH']
    medium = [i for i in issues if i['severity'] == 'MEDIUM']
    low = [i for i in issues if i['severity'] == 'LOW']

    print(f"📊 SUMMARY:")
    print(f"   CRITICAL (>15pt): {len(critical)}")
    print(f"   HIGH (10-15pt):   {len(high)}")
    print(f"   MEDIUM (5-10pt):  {len(medium)}")
    print(f"   LOW (≤5pt):       {len(low)}")
    print(f"   TOTAL:            {len(issues)}\n")

    if critical:
        print(f"{'='*80}")
        print(f"⚠️  CRITICAL ISSUES (>15pt) - MUST FIX")
        print(f"{'='*80}\n")
        for i, issue in enumerate(critical, 1):
            print(f"{i}. {issue['type']}box: {issue['amount']:.2f}pt too {issue['direction']}")
            print(f"   Frame: {issue['frame']}")
            print(f"   Line: {issue['line']}")
            print()

    if high:
        print(f"{'='*80}")
        print(f"⚠️  HIGH PRIORITY (10-15pt) - SHOULD FIX")
        print(f"{'='*80}\n")
        for i, issue in enumerate(high, 1):
            print(f"{i}. {issue['type']}box: {issue['amount']:.2f}pt too {issue['direction']}")
            print(f"   Frame: {issue['frame']}")
            print(f"   Line: {issue['line']}")
            print()

    if medium:
        print(f"{'='*80}")
        print(f"ℹ️  MEDIUM PRIORITY (5-10pt) - Consider fixing")
        print(f"{'='*80}\n")
        for i, issue in enumerate(medium, 1):
            print(f"{i}. {issue['type']}box: {issue['amount']:.2f}pt too {issue['direction']}")
            print(f"   Frame: {issue['frame']}")
            print(f"   Line: {issue['line']}")
            print()

    print(f"{'='*80}")
    print(f"RECOMMENDATIONS:")
    print(f"{'='*80}\n")

    if critical or high:
        print("Fix strategies (in order of preference):")
        print("1. Split long frames into Part 1 / Part 2")
        print("2. Reduce \\vspace values (e.g., 0.3cm → 0.2cm)")
        print("3. Use smaller font sizes for code (\\footnotesize or \\tiny)")
        print("4. Tighten list spacing with \\setlength\\itemsep{-0.2em}")
        print("5. Remove redundant content or comments")
    else:
        print("✅ All formatting issues are minor (≤10pt)")
        print("   Document is acceptable for distribution")

if __name__ == "__main__":
    main()
