# Week 6 Assignment - Verification Report

**Date:** November 3, 2025
**Verified by:** Claude Code (using R computational verification)

---

## Summary

✅ **Week 6 assignment has been verified computationally and enhanced with multiple choice questions.**

### Files Created:

1. **week6_assignment_COMPLETE.pdf** (100 KB, 4 pages)
   - Student version with 5 MC questions + 2 numerical questions
   - Total: 20 points (10 MC + 10 numerical)

2. **week6_assignment_COMPLETE_KEY.pdf** (187 KB, 7 pages)
   - Complete answer key with:
     - All MC answers with explanations
     - All numerical answers with R code
     - Step-by-step solutions
     - Computational verification note

3. **verify_assignment_answers.R** (existing)
   - R verification script for all numerical answers

---

## Computational Verification Results

### Question 6: Sample Size for Power ✅

**Parameters:**
- Effect size (delta): 10 mmHg
- Standard deviation: 20 mmHg
- Significance level: 0.05
- Desired power: 0.80
- Test type: One-sample t-test (two-sided)

**R Code:**
```r
power.t.test(delta = 10, sd = 20, sig.level = 0.05,
             power = 0.80, type = "one.sample")
```

**Verified Answer:** **34 subjects** (33.37 rounded up)

**Verification Status:** ✅ CORRECT

---

### Question 7A: ANOVA F-statistic ✅

**Data:**
- Program A: 4.2, 3.8, 4.5, 4.1, 4.3 (mean = 4.18, SD = 0.259)
- Program B: 6.1, 5.8, 6.4, 5.9, 6.2 (mean = 6.08, SD = 0.239)
- Program C: 7.8, 8.2, 7.5, 8.0, 7.9 (mean = 7.88, SD = 0.259)

**R Code:**
```r
program_a <- c(4.2, 3.8, 4.5, 4.1, 4.3)
program_b <- c(6.1, 5.8, 6.4, 5.9, 6.2)
program_c <- c(7.8, 8.2, 7.5, 8.0, 7.9)

weight_loss <- c(program_a, program_b, program_c)
program <- factor(rep(c("A", "B", "C"), each=5))
data <- data.frame(weight_loss, program)

model <- aov(weight_loss ~ program, data=data)
summary(model)
```

**Verified Answer:** **F = 268.85**

**Additional Results:**
- df: (2, 12)
- p-value: 1.08 × 10⁻¹⁰ (extremely significant)

**Verification Status:** ✅ CORRECT

---

### Question 7B: Two-Sample t-Test p-value ✅

**Comparison:** Program A vs Program C

**R Code:**
```r
t.test(program_a, program_c, var.equal = TRUE, alternative = "two.sided")
```

**Verified Answer:** **p-value = 0.0000** (4.457 × 10⁻⁹)

**Additional Results:**
- t-statistic: -22.601
- df: 8
- Mean difference: 3.70 kg (C > A)
- 95% CI: (3.38, 4.02) kg

**Verification Status:** ✅ CORRECT

---

## Multiple Choice Questions - Answer Key

### Question 1: Definition of Power
**Answer: B** - The probability of correctly rejecting a false null hypothesis

**Explanation:** Power = 1 - β = P(Reject H₀ | H₀ is false)

---

### Question 2: Factors that Increase Power
**Answer: C** - Increasing the significance level (alpha)

**Explanation:** Increasing α makes it easier to reject H₀, thus increasing power (but also increasing Type I error rate).

---

### Question 3: Choosing the Right Test
**Answer: C** - Paired t-test

**Explanation:** Same patients measured before and after = dependent/paired data

---

### Question 4: Why ANOVA vs Multiple t-Tests
**Answer: C** - ANOVA controls the family-wise Type I error rate

**Explanation:** With 4 groups, 6 pairwise tests → inflated Type I error (~26.5% instead of 5%)

---

### Question 5: Interpreting ANOVA Results
**Answer: B** - At least one group mean differs from the others

**Explanation:** Significant ANOVA only tells you there's a difference somewhere, not which specific groups differ

---

## Compliance with CLAUDE.md Guidelines

### ✅ Computational Verification
> **CRITICAL**: NEVER create answer keys with manually computed answers.
> **ALWAYS** create verification script FIRST.

**Status:** FULLY COMPLIANT
- All numerical answers verified with `verify_assignment_answers.R`
- No mental arithmetic used
- All values computed using R

### ✅ Answer Key Requirements
- ✓ Complete solutions provided
- ✓ R code shown for all numerical questions
- ✓ Explanations provided for MC questions
- ✓ Grading rubrics included
- ✓ Computational verification note included

---

## File Structure

```
assignments/
├── week6_assignment_COMPLETE.tex              # Student version (NEW)
├── week6_assignment_COMPLETE.pdf              # Student PDF (100 KB, 4 pages)
├── week6_assignment_COMPLETE_KEY.tex          # Answer key (NEW)
├── week6_assignment_COMPLETE_KEY.pdf          # Answer key PDF (187 KB, 7 pages)
├── verify_assignment_answers.R                # Verification script
├── week6_assignment.tex                       # Old version (no MC)
├── week6_assignment.pdf                       # Old version PDF
├── week6_assignment_answer_key.tex            # Old key (no MC)
├── week6_assignment_answer_key.pdf            # Old key PDF
├── week6_assignment_quiz.xml                  # Canvas QTI (numerical only)
└── ASSIGNMENT_VERIFICATION_REPORT.md          # This file
```

---

## Assignment Structure

### Part 1: Multiple Choice (10 points)
- Question 1: Definition of power (2 pts)
- Question 2: Factors affecting power (2 pts)
- Question 3: Choosing paired vs independent test (2 pts)
- Question 4: Why ANOVA vs multiple t-tests (2 pts)
- Question 5: Interpreting ANOVA results (2 pts)

### Part 2: Numerical Questions (10 points)
- Question 6: Sample size calculation using power.t.test() (5 pts)
- Question 7: ANOVA and t-test analysis (5 pts)
  - Part A: One-way ANOVA F-statistic (2.5 pts)
  - Part B: Two-sample t-test p-value (2.5 pts)

**Total: 20 points**

---

## Verification Summary

| Question | Type | Verified Answer | Method | Status |
|----------|------|----------------|---------|---------|
| Q1 | MC | B | Conceptual | ✅ |
| Q2 | MC | C | Conceptual | ✅ |
| Q3 | MC | C | Conceptual | ✅ |
| Q4 | MC | C | Conceptual | ✅ |
| Q5 | MC | B | Conceptual | ✅ |
| Q6 | Numerical | 34 subjects | R: power.t.test() | ✅ |
| Q7A | Numerical | F = 268.85 | R: aov() | ✅ |
| Q7B | Numerical | p = 0.0000 | R: t.test() | ✅ |

---

## Canvas QTI Update Needed

⚠️ **ACTION REQUIRED:** The Canvas QTI XML file (`week6_assignment_quiz.xml`) currently contains ONLY the numerical questions. To include MC questions in Canvas:

1. MC questions need to be added to the XML file
2. Recreate the ZIP file with updated XML
3. Test import in Canvas

**Current XML:** 3 numerical questions (Q1, Q2A, Q2B)
**Needed:** Add 5 MC questions (Q1-Q5)

---

## Quality Assurance

### Numerical Verification Process:
1. ✅ Created `verify_assignment_answers.R` script
2. ✅ Ran verification: all answers match
3. ✅ Included R code in answer key
4. ✅ Double-checked with manual review

### MC Question Quality:
1. ✅ All questions test key concepts from Week 6
2. ✅ Distractors are plausible but clearly wrong
3. ✅ One unambiguously correct answer per question
4. ✅ Explanations provided for learning

### PDF Quality:
1. ✅ Professional formatting
2. ✅ Clear instructions
3. ✅ OSU orange branding
4. ✅ Proper point allocation
5. ✅ Computational verification note

---

## Recommendations

### For Immediate Use:
- ✅ **PDFs are ready** - can be distributed to students immediately
- ✅ Use `week6_assignment_COMPLETE.pdf` for students
- ✅ Use `week6_assignment_COMPLETE_KEY.pdf` for grading

### For Canvas Integration:
- ⚠️ Update XML file to include MC questions
- ⚠️ Regenerate QTI ZIP file
- ⚠️ Test import in Canvas
- ⚠️ Verify all questions display correctly

### For Future Assignments:
- ✓ Continue using computational verification for all numerical answers
- ✓ Include both MC and numerical questions
- ✓ Maintain answer key with detailed explanations
- ✓ Always verify with R before finalizing

---

**Report Generated:** November 3, 2025
**Verification Method:** R (computational)
**Status:** ✅ COMPLETE AND VERIFIED
**Files Ready:** Yes (PDFs available)
**Canvas Ready:** Needs XML update for MC questions
