# Making LaTeX Beamer Slides Fit: The DVI → Fix → PDF Workflow

## Overview

When Beamer slides have text running off pages, use this systematic workflow to identify and fix formatting issues.

## The Problem

LaTeX PDF compilation warnings about overfull boxes are often vague and don't provide precise measurements. DVI compilation provides detailed measurements that make it easier to identify and prioritize formatting issues.

## The Workflow

### 1. Compile to DVI First

Instead of compiling directly to PDF, first compile to DVI to get precise measurements:

```bash
latex -interaction=nonstopmode filename.tex
```

This will show warnings like:
```
Overfull \vbox (36.20pt too high) detected at line 234
```

### 2. Use the Python Analysis Script

For systematic analysis, use the `check_dvi.py` script:

```bash
# Auto-detect .tex file (if only one in directory)
python3 check_dvi.py

# Or specify the file explicitly
python3 check_dvi.py filename.tex
```

**What it does:**
- Compiles your slides to DVI
- Extracts all overfull vbox warnings
- Sorts by severity (worst first)
- Categorizes issues by severity level
- Provides summary statistics

**Severity Levels:**
- **CRITICAL** (>15pt): Must fix - text is significantly cut off
- **HIGH** (10-15pt): Should fix - noticeable overflow
- **MEDIUM** (5-10pt): Minor issue - may be acceptable
- **LOW** (≤5pt): Negligible - can usually ignore

### 3. Fix Systematically

**Key Principle:** Fix worst offenders first (highest pt values)

Start with CRITICAL issues, then work down to HIGH, then MEDIUM if needed. LOW issues can usually be ignored.

### 4. Common Fixes (in order of preference)

#### Option A: Split Into Multiple Slides (PREFERRED)
**When to use:** Slides with >20pt overfull, especially with dense code

**How:**
```latex
% BEFORE: One long slide
\begin{frame}[fragile]
\frametitle{Code Example: Complex Analysis}
\tiny
\begin{verbatim}
# Data setup
data <- c(...)
# Long calculation code
...
# Visualization code
plot(...)
\end{verbatim}
\end{frame}

% AFTER: Split into Part 1 and Part 2
\begin{frame}[fragile]
\frametitle{Code Example: Complex Analysis (Part 1 - Setup)}
\small
\begin{verbatim}
# Data setup
data <- c(...)
# Calculation code
...
\end{verbatim}
\end{frame}

\begin{frame}[fragile]
\frametitle{Code Example: Complex Analysis (Part 2 - Visualization)}
\small
\begin{verbatim}
# Visualization code
plot(...)
# Interpretation
...
\end{verbatim}
\end{frame}
```

**Benefits:**
- Improves pedagogy (natural teaching breaks)
- Allows larger, more readable fonts
- Better for student note-taking

#### Option B: Reduce Font Size
**When to use:** Slides with 10-30pt overfull that can't be easily split

**Font size hierarchy:**
```latex
\small          % Try this first
\footnotesize   % If \small not enough
\tiny           % Last resort for dense code
```

**Example:**
```latex
\begin{frame}[fragile]
\frametitle{Complex Code Example}
\footnotesize  % Changed from \small
\begin{verbatim}
... code here ...
\end{verbatim}
\end{frame}
```

#### Option C: Reduce Vertical Spacing
**When to use:** Slides with 5-15pt overfull

**Common adjustments:**
```latex
% Reduce vspace between sections
\vspace{0.2cm}  % Instead of 0.3cm or 0.5cm

% Tighten list item spacing
\begin{itemize}\setlength\itemsep{-0.2em}  % Or -0.1em
\item First item
\item Second item
\end{itemize}

% Remove unnecessary blank lines between code sections
```

#### Option D: Condense Content
**When to use:** Slides with 5-10pt overfull

- Remove redundant comments
- Combine related items
- Remove unnecessary blank lines in code
- Shorten explanatory text

### 5. Verify Fixes

After making changes, re-run the DVI check:

```bash
python3 check_dvi.py  # Auto-detects file
# or
python3 check_dvi.py filename.tex  # Explicit file
```

**Success criteria:**
- 0 CRITICAL issues (>15pt)
- 0 HIGH issues (10-15pt)
- MEDIUM/LOW issues acceptable (script will say "SUCCESS")

### 6. Final PDF Compilation

Once DVI check shows success, compile to PDF:

```bash
pdflatex filename.tex
pdflatex filename.tex  # Run twice for proper references
```

## Real-World Example

**Fixing a Dense Code Slide**

**Initial state:** 111.78pt too high [CRITICAL]

**Attempt 1:** Changed \tiny → \footnotesize
- Result: Still 76pt overfull (made it worse!)

**Attempt 2:** Split into two slides
```latex
% Part 1: Setup and calculation code
% Part 2: Results and function output
```
- Result: Reduced to 50pt overfull

**Attempt 3:** Changed Part 1 back to \tiny for dense code section
- Result: SUCCESS - reduced to <5pt overfull

**Lesson:** For very dense code slides, splitting + small font works better than splitting + large font

## Decision Tree

```
Is slide overfull by >15pt (CRITICAL)?
├─ YES → Can content be logically split?
│   ├─ YES → Split into Part 1/Part 2
│   │         Use \small or \footnotesize
│   │         Re-check with DVI
│   └─ NO → Is it mostly code?
│       ├─ YES → Use \tiny or \footnotesize
│       └─ NO → Reduce vspace and itemsep
└─ NO → Is it 10-15pt (HIGH)?
    ├─ YES → Try \footnotesize or reduce spacing
    └─ NO → Leave as-is if <10pt
```

## Quick Reference

### check_dvi.py Output
```
Total overfull vboxes: 8

Top 10 worst offenders:
--------------------------------------------------
 1. Line  917: 111.78pt too high [CRITICAL]  ← Fix this first
 2. Line  951:  76.93pt too high [CRITICAL]  ← Then this
 3. Line  985:  75.68pt too high [CRITICAL]
 4. Line  277:   6.07pt too high [MEDIUM]    ← Can probably ignore
 5. Line  128:   5.03pt too high [MEDIUM]
```

### Fix Priority
1. CRITICAL (>15pt) - Must fix
2. HIGH (10-15pt) - Should fix
3. MEDIUM (5-10pt) - Optional
4. LOW (≤5pt) - Ignore

### Common Patterns

**Code Slides:**
- Dense code (>25 lines): Split into parts + \small
- Medium code (15-25 lines): Try \footnotesize first
- Complex visualizations: Often needs \tiny or splitting

**Text Slides:**
- Reduce \vspace{0.3cm} → \vspace{0.2cm}
- Use \setlength\itemsep{-0.2em} in lists
- Remove blank lines between sections

**Mixed Content:**
- Split code from output/interpretation
- Put examples on separate slides
- Use \small for main content, \footnotesize for details

## Tips

1. **Always fix worst offenders first** - Fixing a 100pt issue helps more than fixing 10 5pt issues
2. **Prefer splitting to shrinking** - Better pedagogy and readability
3. **Use \tiny sparingly** - Reserve for dense code that can't be split
4. **Test iteratively** - Fix, check, fix, check
5. **Document splits** - Use "(Part 1)", "(Part 2)" in frame titles

## Files

- **check_dvi.py** - Automated DVI analysis script (place in slides directory)
- **CLAUDE.md** - Course-specific instructions that reference this workflow
- **make_it_fit.md** - This detailed reference guide (shared across courses)

## Success Metrics

A successful fix means:
```
==================================================
Summary by Severity:
  CRITICAL (>15pt):  0
  HIGH (10-15pt):    0
  MEDIUM (5-10pt):   2
  LOW (<=5pt):       4
==================================================

✓ SUCCESS: All major issues resolved!
  (Only minor overfull boxes <10pt remaining)
```
