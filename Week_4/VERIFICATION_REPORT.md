# Week 4 Computational Verification Report

**Date:** October 19, 2025
**Topic:** Confidence Intervals
**Verified By:** R/Python computational scripts

---

## Summary

**ALL WEEK 4 COMPUTATIONAL CONTENT HAS BEEN VERIFIED WITH R/PYTHON**

✅ **Slides** - 5 examples verified
✅ **Worksheets** - 6 problems verified
✅ **Worksheet Answer Key** - All solutions verified
✅ **Lab** - 3 practice problems verified
✅ **Assignment Answer Key** - 9 computational questions verified

**Total Verifications:** 23 separate computational checks
**Errors Found:** 0
**Status:** All materials ready for use

---

## 1. Slides Verification

**File:** `slides/week4_slides.tex`
**Verification Script:** `slides/verify_slide_calculations.R`
**Status:** ✅ ALL CORRECT

### Examples Verified:

1. **Blood Pressure Study** (Slides ~261-277)
   - SE = 2.52 ✓
   - t-critical = 2.064 ✓
   - ME = 5.20 ✓
   - 95% CI = (123.2, 133.6) ✓

2. **Pain Medication Study** (Slides ~307-327)
   - SE = 2.10 ✓
   - t-critical = 2.131 ✓
   - ME = 4.48 ✓
   - 95% CI = (40.7, 49.7) ✓

3. **Sample Size - Cholesterol Study** (Slides ~620-639)
   - Calculated n = 245.86 ✓
   - Rounded n = 246 ✓

4. **Sample Size - Prevalence Scenario 1** (p=0.5) (Slides ~709-711)
   - Calculated n = 1067.1 ✓
   - Rounded n = 1068 ✓

5. **Sample Size - Prevalence Scenario 2** (p=0.15) (Slides ~714-716)
   - Calculated n = 544.2 ✓
   - Rounded n = 545 ✓

---

## 2. Worksheet Verification

**File:** `worksheets/week4_confidence_intervals_worksheet_KEY.tex`
**Verification Script:** `worksheets/verify_answers.R`
**Status:** ✅ ALL CORRECT

### Problems Verified:

**Problem 1: CI for Population Mean**
- SE = 1.923 ✓
- df = 19 ✓
- t-critical = 2.093 ✓
- ME = 4.0249 ✓
- 95% CI = (38.48, 46.52) ✓

**Problem 2: Effect of Confidence Level**
- 90% CI = (39.17, 45.83) ✓
- 99% CI = (37, 48) ✓

**Problem 3: CI for a Proportion**
- p̂ = 0.872 ✓
- SE = 0.0211 ✓
- 95% CI = (0.8306, 0.9134) = (83.06%, 91.34%) ✓

**Problem 4: Sample Size Planning**
- Sample size (ME=10): n = 171 ✓
- Sample size (p=0.5): n = 385 ✓

**Problem 5: Comparing Two CIs**
- Sample A CI = (24.97, 31.83), width = 6.87 ✓
- Sample B CI = (26.64, 30.16), width = 3.52 ✓

**Problem 6: Integration Problem**
- 95% CI = (10.97, 14.63) ✓
- Sample size = 50 ✓
- Proportion CI = (39.32%, 71.79%) ✓

---

## 3. Lab Verification

**File:** `Lab/week4_lab.tex`
**Verification Script:** `Lab/verify_lab_problems.R`
**Status:** ✅ ALL CORRECT

### Practice Problems Verified:

**Problem 1: Clinical Trial (Cholesterol Reduction)**
- 95% CI = (23.52, 32.48) mg/dL ✓
- 99% CI = (21.96, 34.04) mg/dL ✓
- Verified with t.test() ✓

**Problem 2: Adverse Events (Proportion)**
- p̂ = 0.0533, conditions: np̂ = 8, n(1-p̂) = 142 ✓
- 95% CI = (1.74%, 8.93%) ✓
- Verified with prop.test() ✓

**Problem 3: Study Planning (Sample Size)**
- For ME = 0.2°F: n = 48 subjects ✓
- For ME = 0.1°F: n = 189 subjects ✓
- Relationship: halving ME requires 4× sample size ✓

---

## 4. Assignment Verification

**File:** `assignments/week4_assignment_with_answers.tex`
**Verification Script:** `assignments/verify_assignment_answers.R`
**Status:** ✅ ALL CORRECT

### Computational Questions Verified:

**Q2: Critical Value Selection**
- t(14) = 2.145 ✓

**Q4: Standard Error**
- SE = 2 ✓

**Q5: Fill-in CI Calculation** (20 points)
- a) SE = 1.923 ✓
- b) df = 19, t = 2.093 ✓
- c) ME = 4.025 ✓
- d) 95% CI = (48.27, 56.33) ✓

**Q8: Proportion**
- p̂ = 0.75 ✓

**Q9: SE for Proportion**
- SE ≈ 0.031 ✓

**Q11: Sample Size Effect**
- Sample size 4× → ME halved ✓

**Q12: Sample Size for Proportion**
- n = 385 ✓

**Q16: R Code for Proportion CI** (10 points)
- a) p̂ = 0.750 ✓
- b) np̂ = 45, n(1-p̂) = 15 ✓
- c) SE = 0.0559 ✓
- d) 95% CI = (0.640, 0.860) ✓
- e) Percentage = (64.0%, 86.0%) ✓

---

## Verification Scripts Summary

All verification scripts are saved alongside the materials they verify:

```
Week_4/
├── slides/
│   ├── week4_slides.tex
│   ├── week4_slides.pdf
│   ├── week4_slides_code.R ✓ (NEW - Student R code)
│   └── verify_slide_calculations.R ✓ (Verification)
│
├── worksheets/
│   ├── week4_confidence_intervals_worksheet.tex
│   ├── week4_confidence_intervals_worksheet_KEY.tex
│   └── verify_answers.R ✓
│
├── Lab/
│   ├── week4_lab.tex
│   ├── week4_lab_code.R ✓ (NEW - Student R code)
│   └── verify_lab_problems.R ✓ (Verification)
│
└── assignments/
    ├── week4_assignment_with_answers.tex
    └── verify_assignment_answers.R ✓
```

### NEW: Student R Code Files

**Added comprehensive R code for students:**

1. **`slides/week4_slides_code.R`** - Complete R code for all slide examples
   - Example 1: Blood Pressure Study (manual + t.test)
   - Example 2: Pain Medication Study
   - Example 3: Sample Size - Cholesterol Study
   - Example 4: Sample Size - Prevalence (p=0.5)
   - Example 5: Sample Size - Prevalence (p=0.15)
   - Includes both manual calculations and R functions
   - Summary of key R functions

2. **`Lab/week4_lab_code.R`** - Complete R solutions for all lab problems
   - Problem 1: Clinical Trial (95% and 99% CIs)
   - Problem 2: Adverse Events (proportion CI)
   - Problem 3: Study Planning (sample size calculations)
   - Both manual and function-based approaches
   - Complete interpretations and explanations
   - Summary of key R functions

---

## Conclusion

**All Week 4 computational content has been verified using R.**

- **No errors found** in any materials
- **23 separate calculations** verified across all materials
- **4 verification scripts** provide complete audit trail
- All scripts can be re-run at any time to reverify

### Compliance with Course Standards:

✅ No mental arithmetic used
✅ All numerical answers computed with R/Python
✅ Verification scripts saved with materials
✅ Complete audit trail provided
✅ Materials ready for student distribution

---

**Verification completed:** October 19, 2025
**Verified by:** R statistical computing environment
**Next verification:** Required only if materials are updated
