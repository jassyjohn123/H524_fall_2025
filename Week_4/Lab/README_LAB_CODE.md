# Week 4 Lab - R Code Files

This directory contains R code files for the Week 4 Confidence Intervals lab.

## Main File: `week4_lab_code_COMPLETE.R`

**This is the comprehensive file students should use.**
- **Size:** 39 KB
- **Lines:** 1,091 lines of code and explanations
- **Verified:** All calculations checked ✓

### Contents:
1. **All Lab Exercises** (Parts 1-5) WITH ANSWERS:
   - Exercise 1.1: Manual CI calculation for blood pressure data
   - Exercise 1.2: Using t.test() function
   - Exercise 1.3: Different confidence levels (90%, 95%, 99%)
   - Exercise 1.4: Effect of sample size on CI width
   - Exercise 2.1: Visual normality checks (histogram, boxplot, Q-Q plot)
   - Exercise 2.2: Shapiro-Wilk test for normality
   - Exercise 2.3: Robustness with skewed data
   - Exercise 3.1: Vaccine efficacy (proportion CI)
   - Exercise 3.2: Diabetes screening prevalence
   - Exercise 4.1: Sample size for estimating a mean
   - Exercise 4.2: How margin of error affects sample size
   - Exercise 4.3: Sample size for proportions
   - Exercise 5.1: Meaning of 95% confidence (simulation)
   - Exercise 5.2: Plotting multiple CIs
   - **NEW:** Answers to all "Your Turn" exercises
   - **NEW:** Answers to all discussion questions

2. **All Practice Problem Solutions** (Problems 1-4) WITH COMPLETE EXPLANATIONS:
   - Problem 1: Clinical Trial (cholesterol reduction)
     - Parts a-d with complete calculations
   - Problem 2: Adverse Events (proportion)
     - Parts a-c with condition checking
   - Problem 3: Study Planning (sample size)
     - Parts a-c showing relationship between ME and n
   - Problem 4: Assumption Checking (reaction times)
     - Diagnostic plots and Shapiro-Wilk test

### How to Use:

**Run the entire script:**
```r
source("week4_lab_code_COMPLETE.R")
```

**Run specific sections in RStudio:**
- Highlight the code for a specific exercise or problem
- Click "Run" or press Cmd+Enter (Mac) / Ctrl+Enter (Windows)

**Copy code for your own work:**
- Open the file in any text editor
- Copy the relevant section
- Paste into your own R script

### What You'll See:

When you run the complete file, you'll see:
- All calculations with step-by-step output
- Diagnostic plots will appear in the Plots pane
- Clear section headings for easy navigation
- Verification that all calculations match the answer key

### File Organization:

```
Lab/
├── week4_lab.pdf                          # Student lab instructions
├── week4_lab_KEY.pdf                      # Answer key (instructor)
├── week4_lab_code_COMPLETE.R              # ← USE THIS FILE
├── week4_lab_KEY_verify.R                 # Verification script (instructor)
├── VERIFY_ALL_LAB_MATERIALS.R             # Comprehensive verification (instructor)
└── README_LAB_CODE.md                     # This file
```

### Notes for Students:

1. **All numerical values have been verified** using R - you can trust these calculations
2. **Code matches the answer key exactly** - use this to check your work
3. **Includes both manual calculations and R functions** - learn both approaches
4. **Practice problems show complete solutions** - study these for homework/exams

### Notes for Instructors:

- This file combines all lab exercises with practice problem solutions
- All calculations verified using `VERIFY_ALL_LAB_MATERIALS.R`
- No computational errors found (verified 10/22/2025)
- Students can run this to see complete worked examples
- Consider providing this after students attempt problems on their own

## Other R Files:

- `week4_lab_KEY_verify.R` - Verifies only practice problem answers
- `VERIFY_ALL_LAB_MATERIALS.R` - Verifies all lab materials (exercises + problems)
- `verify_slide_calculations.R` - Verifies slide calculations
- `week4_slides_code.R` - Code from lecture slides

## Questions?

If you find any errors or have questions about the code:
- Check the answer key PDF first
- Run the verification script to confirm calculations
- Contact instructor if discrepancies remain
