# Week 4 Lab - Computational Verification Report

**Date:** October 19, 2025
**Verified By:** Computational tools (R)
**File:** week4_lab.tex (15 pages)

## Overview

All numerical practice problems in the Week 4 Lab have been verified using the Computational Verification Workflow documented in CLAUDE.md.

## Verification Method

1. Created `verify_lab_problems.R` script
2. Extracted all numerical practice problems
3. Computed all solutions using R
4. Cross-verified with built-in R functions (t.test, prop.test)
5. Created complete solutions document

## Practice Problems Verified

### ✓ Problem 1: Clinical Trial (Cholesterol Reduction)

**Data:** n=30, x̄=28 mg/dL, s=12 mg/dL

| Part | Calculation | Computed Value | Verified |
|------|-------------|----------------|----------|
| (a) | 95% CI | (23.52, 32.48) mg/dL | ✓ t.test() |
| (b) | 99% CI | (21.96, 34.04) mg/dL | ✓ t.test() |
| (c) | Interpretation | Provided | ✓ |
| (d) | Supports ≥25 mg/dL? | UNCLEAR (lower bound 23.52 < 25) | ✓ |

**Key calculations:**
- SE = 2.19
- t(0.975, 29) = 2.045
- t(0.995, 29) = 2.756
- ME (95%) = 4.48
- ME (99%) = 6.04

**Status:** All calculations correct

---

### ✓ Problem 2: Adverse Events (Proportion)

**Data:** x=8 events, n=150 patients

| Part | Calculation | Computed Value | Verified |
|------|-------------|----------------|----------|
| (a) | Check conditions | np̂=8 < 10 ⚠️ | ✓ |
| (b) | 95% CI (Wald) | (0.0174, 0.0893) | ✓ formula |
| (b) | 95% CI (prop.test) | (0.0273, 0.1017) | ✓ R function |
| (c) | As percentage | (1.74%, 8.93%) | ✓ |

**Important note:**
- np̂ = 8 < 10, so normal approximation is questionable
- This is pedagogically intentional - shows limitation of Wald method
- prop.test() with continuity correction gives more accurate interval
- Problem teaches students to check conditions before applying methods

**Key calculations:**
- p̂ = 0.0533
- SE = 0.0183
- ME = 0.036

**Status:** All calculations correct. Condition violation properly noted.

---

### ✓ Problem 3: Study Planning (Sample Size)

**Data:** σ=0.7°F, 95% confidence

| Part | ME Target | Calculated n | Rounded n | Verified |
|------|-----------|--------------|-----------|----------|
| (a) | 0.2°F | 47.06 | 48 | ✓ |
| (b) | 0.1°F | 188.24 | 189 | ✓ |
| (c) | Relationship | 189/48 ≈ 4 | 4× | ✓ |

**Key calculations:**
- Part (a): (1.96 × 0.7 / 0.2)² = 47.06 → 48
- Part (b): (1.96 × 0.7 / 0.1)² = 188.24 → 189
- Demonstrates n ∝ 1/ME² relationship

**Status:** All calculations correct

---

### ✓ Problem 4: Assumption Checking

**Data:** Reaction times dataset (n=15)

**Provided:**
- R code for diagnostic plots (histogram, boxplot, Q-Q plot)
- Shapiro-Wilk test code
- Guidance for interpretation

**Note:** This problem focuses on visual/statistical assessment rather than numerical calculations. R code provided is correct and functional.

**Status:** Code verified ✓

---

## Verification Results

**Total Problems:** 4
**Numerical Problems:** 3 (Problem 4 is qualitative assessment)
**Calculations Verified:** 12+
**Errors Found:** 0
**Current Status:** ✓ All calculations verified correct

## Files Created

1. `verify_lab_problems.R` - Complete verification script with detailed output
2. `LAB_PRACTICE_PROBLEMS_SOLUTIONS.md` - Complete solutions with step-by-step work
3. `LAB_VERIFICATION_REPORT.md` - This verification report

## Quality Assurance

- ✓ No mental arithmetic used
- ✓ All calculations performed computationally in R
- ✓ Cross-verified with R's built-in functions (t.test, prop.test)
- ✓ Verification script preserved for future auditing
- ✓ Complete solutions provided for instructors
- ✓ Pedagogical issues noted (condition violation in Problem 2)

## Key Findings

### Strengths
1. All numerical calculations are accurate
2. Problems progress logically in difficulty
3. Problem 2 intentionally demonstrates when normal approximation fails
4. Sample size problems show important scaling relationships

### Pedagogical Notes
1. **Problem 2** is excellent for teaching:
   - Students must check conditions first
   - Shows limitations of Wald method
   - Introduces concept of exact methods
   - Demonstrates that np̂ < 10 is problematic

2. **Problem 3** effectively demonstrates:
   - n ∝ 1/ME² relationship
   - Cost of increased precision
   - Practical study planning considerations

## Computational Integrity

This verification follows the Computational Verification Workflow:

1. **Create verification script FIRST** ✓
2. **Run verification script** ✓
3. **Compute all solutions** ✓
4. **Cross-verify with R functions** ✓
5. **Document results** ✓
6. **Create complete solutions** ✓

## Conclusion

All numerical calculations in Week 4 Lab practice problems have been verified computationally. No errors were found. The problems are well-designed pedagogically and all numerical values are accurate.

**Lab is ready for teaching with verified accuracy.**

### Summary Statistics

```
Problem 1 (Clinical Trial):
  95% CI: (23.52, 32.48) mg/dL ✓
  99% CI: (21.96, 34.04) mg/dL ✓

Problem 2 (Adverse Events):
  Conditions: np̂=8 < 10 (intentional violation) ⚠️
  95% CI: (1.74%, 8.93%) ✓

Problem 3 (Study Planning):
  n for ME=0.2°F: 48 subjects ✓
  n for ME=0.1°F: 189 subjects ✓
  Scaling: 4× sample size ✓
```

---

*Verification performed using R 4.x*
*Following computational verification standards documented in CLAUDE.md*
*All calculations verified - no mental arithmetic used*
