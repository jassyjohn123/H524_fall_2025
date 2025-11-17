# Week 6 R Code Verification Report

**Date:** November 3, 2025
**Verified by:** Computational verification using R (following best practice: NEVER use mental math, ALWAYS verify with R)

## Summary

All R code in Week 6 materials has been verified using actual R calculations. Several critical errors were found and fixed.

---

## SLIDES: week6_slides.tex ✅

### Errors Found and Fixed:

#### 1. **ANOVA Output (Line 948) - MAJOR ERROR** ❌ → ✅
- **Location:** Slide "ANOVA in R (Part 2 - Results)"
- **Error:** Incorrect Sum of Squares and Mean Square values
- **Wrong values:**
  ```
  # dose         2 632.53  316.27  113.1  <0.001 ***
  # Residuals   12  39.60    3.30
  ```
- **Corrected to:**
  ```
  # dose         2  746.1   373.1   113.1  1.64e-08 ***
  # Residuals   12   39.6     3.3
  ```
- **Impact:** Students copying these values would have completely wrong ANOVA calculations

#### 2. **Power Calculation Discrepancy (Line 299)** ❌ → ✅
- **Location:** Slide "Sample Size Calculation in R (continued)"
- **Error:** Claimed `power.t.test()` gives power = 0.385, but it actually gives 0.360
- **Wrong:**
  ```r
  #           power = 0.385
  # Power = 0.385 (matches our calculation!)
  ```
- **Corrected to:**
  ```r
  #           power = 0.360
  # Power = 0.360 (slightly lower than z-based calculation)
  ```
- **Explanation:** Manual calculation using z-distribution gives 0.385, but `power.t.test()` correctly uses t-distribution giving 0.360

### Verification Results:
✅ All 7 major calculations verified correct:
1. ✓ Power calculation (manual): 0.385
2. ✓ Sample size for power=0.80: n=73
3. ✓ Power for n=25: 0.360
4. ✓ Two-sample t-test (tumor growth): t=1.578, p=0.066
5. ✓ Paired t-test (blood pressure): t=12.24, p=3.24e-07
6. ✓ ANOVA (cholesterol): F=113.1, SS=746.1
7. ✓ Tukey HSD: All pairwise differences correct

---

## SLIDES CODE: week6_slides_code.R ✅

### Errors Found and Fixed:

#### 1. **Lines 251-252: Invalid c(...) syntax** ❌ → ✅
- **Error:** Template code with `c(...)` caused "... used in incorrect context"
- **Fix:** Commented out non-executable template code

#### 2. **Lines 272-283: Non-existent objects** ❌ → ✅
- **Error:** References to `mydata`, `outcome`, `treatment` that don't exist
- **Fix:** Commented out template code with clear "TEMPLATE - not executable" label

#### 3. **Lines 289-302: References undefined model** ❌ → ✅
- **Error:** Tries to run `TukeyHSD(model)` on non-existent model
- **Fix:** Commented out with template label

---

## LAB CODE: week6_lab_code.R ⚠️ → ✅

### Errors Found and Fixed:

#### 1. **Line 486-487: Duplicate main argument** ❌ → ✅
- **Error:** `plot(TukeyHSD(model), main="...")` - formal argument matched twice
- **Problem:** `plot.TukeyHSD()` method already has internal `main` parameter
- **Fix:** Removed custom `main` argument

#### 2. **Lines 520, 522, 570, 572: Python-style string repetition** ❌ → ✅
- **Error:** `cat("="*70, "\n")` - invalid R syntax
- **Fix:** Changed to `cat(paste(rep("=", 70), collapse=""), "\n")`

#### 3. **Lines 561-564: COMPLETELY WRONG POWER CALCULATIONS** ❌ → ✅
- **Location:** Practice Problem 1 interpretation
- **Critical Error:** Comments describe WRONG parameter values!
- **Wrong interpretation (with delta=5, sd=12):**
  ```
  - To detect a 5-point improvement with 80% power, need n=91 students
  - For 90% power, need n=122 students
  - With only 50 students, power is only 61.4% (inadequate)
  ```
- **ACTUAL R results (verified):**
  ```
  - To detect a 5-point improvement with 80% power, need n=48 students
  - For 90% power, need n=63 students
  - With only 50 students, power is 82.3% (adequate!)
  ```
- **Impact:** This told students they needed nearly TWICE as many subjects as actually required!
- **Root cause:** Comments were copied from a different problem (likely delta=3.5 instead of 5)

### Verification Results:
✅ All major calculations verified correct after fixes:
1. ✓ Power for n=50 (delta=5, sd=12): 82.3%
2. ✓ Sample size for power=0.80: n=48
3. ✓ Sample size for power=0.90: n=63
4. ✓ Tumor growth t-test: t=1.578, p=0.066
5. ✓ Blood pressure paired t-test: t=12.24
6. ✓ ANOVA cholesterol: F=113.1
7. ✓ Tukey HSD: All differences correct
8. ✓ Weight loss study: Cohen's d=4.69

---

## Methodology

Following the CLAUDE.md mandate for computational verification:

> **CRITICAL**: NEVER create answer keys with manually computed numerical answers.
> **ALWAYS** create a verification script (R or Python) that computes ALL numerical answers.

### Verification Process:
1. Created `verify_slides_calculations.R` - checks all 7 major numerical claims in slides
2. Created `verify_lab_calculations.R` - checks all numerical claims in lab
3. Used actual R calculations to verify every number
4. No mental arithmetic was used - all values computed by R
5. Created audit trail of all calculations

---

## Files Modified

### Slides:
- ✅ `week6_slides.tex` - Fixed ANOVA values and power calculation
- ✅ `week6_slides_code.R` - Fixed template code sections

### Lab:
- ✅ `week6_lab_code.R` - Fixed plot error, string repetition, and power interpretations

### Verification Scripts Created:
- ✅ `slides/verify_slides_calculations.R` - Comprehensive slides verification
- ✅ `Lab/verify_lab_calculations.R` - Comprehensive lab verification
- ✅ `slides/test_week6_code.R` - Quick test of all slide code blocks

---

## Lessons Learned

### Why This Matters (from CLAUDE.md):

> **Real example from Week 2 grading:**
> - Question 15b asked for P(X ≥ 16) where X ~ Binomial(20, 0.75)
> - Old answer key had: **0.203** (WRONG!)
> - Verified with Python: **0.4148** (CORRECT)
> - Impact: 9 students incorrectly graded until verification caught the error

### Errors Prevented in Week 6:

1. **ANOVA Values:** Students would have copied wrong SS and MS values into homework
2. **Power Calculations:** Students would have been told they needed 91 subjects when 48 was adequate
3. **R Code Compilation:** Lab code wouldn't run, preventing students from learning

### Best Practices Applied:

✓ All numerical values verified with R
✓ No mental arithmetic used
✓ Verification scripts created as audit trail
✓ Template code clearly labeled as non-executable
✓ Comments match actual R output

---

## Final Status

### Slides: ✅ VERIFIED CORRECT
- All calculations match R output
- All code compiles without errors
- All numerical claims verified

### Lab: ✅ VERIFIED CORRECT
- All calculations match R output
- All code runs start-to-finish without errors
- All interpretations match actual R results

### Code Quality: ✅ EXCELLENT
- Follows CLAUDE.md computational verification principles
- Includes verification scripts for audit trail
- Template code clearly marked
- All numerical values computationally verified

---

**Report Generated:** November 3, 2025
**Verification Method:** Computational (R) - No Mental Math
**Files Verified:** 3 (slides, slides_code, lab_code)
**Errors Found:** 8
**Errors Fixed:** 8
**Final Status:** ✅ ALL VERIFIED CORRECT
