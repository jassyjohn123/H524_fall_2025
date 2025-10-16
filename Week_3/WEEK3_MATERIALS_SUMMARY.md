# Week 3 Materials Summary
## H524 Introduction to Biostatistics - Fall 2025

**Topic:** Probability Distributions and Sampling
**Chapters:** Pagano & Gauvreau Chapter 7 (7.1, 7.2, 7.4) and Chapter 8
**Created:** October 12, 2025

---

## Complete Materials Checklist

### ✓ Lecture Materials (Monday & Wednesday)
- **slides/week3_slides.pdf** (305 KB, 48 pages)
  - Monday: Binomial Distribution (Ch 7.1), Normal Distribution (Ch 7.2)
  - Wednesday: Other Distributions (Ch 7.4), Sampling Distributions (Ch 8), Central Limit Theorem
  - Includes: Review, theoretical concepts, R examples, AI integration sections
  - Features: OSU orange branding, medical examples, practice problems

- **slides/code/week3_lecture_code.R** (17 KB)
  - Comprehensive R demonstrations for all lecture examples
  - 10 sections covering binomial, normal, t-distribution, sampling distributions, CLT, confidence intervals
  - Ready to run in class or for students to download

### ✓ In-Class Worksheet
- **worksheets/week3_distributions_worksheet.pdf** (152 KB)
  - 5 comprehensive problems covering all major topics
  - Appropriate length for 50-minute in-class session
  - Includes reflection questions

- **worksheets/week3_distributions_worksheet_answer_key.pdf** (184 KB)
  - Complete solutions with detailed explanations
  - Step-by-step calculations for instructor reference

### ✓ Lab Session (Wednesday)
- **Lab/week3_lab.pdf** (143 KB)
  - Hands-on R tutorial covering 4 main parts (90 minutes)
  - Part 1: Binomial Distribution in R (20 min)
  - Part 2: Normal Distribution in R (25 min)
  - Part 3: Sampling Distributions and CLT (25 min)
  - Part 4: Confidence Intervals (20 min)
  - Includes 5 practice problems with detailed instructions
  - AI-enhanced learning tips section

- **Lab/code/week3_lab_code.R** (27 KB)
  - Complete solutions for all lab exercises and practice problems
  - Well-commented for student reference
  - Includes all visualizations

### ✓ Homework Assignment
- **assignments/week3_assignment.pdf** (157 KB)
  - 100 points total + 5 bonus points
  - Due: End of Week 4
  - 5 parts covering all topics:
    - Part 1: Binomial Distribution (25 points)
    - Part 2: Normal Distribution (25 points)
    - Part 3: Sampling Distributions and CLT (25 points)
    - Part 4: Confidence Intervals (20 points)
    - Part 5: Integration and R Applications (5 points)
    - Bonus: AI-Enhanced Learning (5 points)

- **assignments/week3_assignment_answer_key.pdf** (194 KB)
  - Complete solutions with detailed grading notes
  - Step-by-step calculations for all problems
  - R code solutions included
  - Grading rubric and summary table

### ✓ Canvas Integration
- **assignments/week3_assignment_canvas.zip** (4.5 KB)
  - QTI format ready for Canvas import
  - Contains: week3_assignment_quiz.xml and imsmanifest.xml
  - 17 questions (16 main + 1 bonus)
  - Configured with essay questions for mathematical work
  - 240-minute time limit, 1 attempt

---

## Content Coverage

### Binomial Distribution
- Four conditions for binomial experiments
- Probability mass function
- Expected value: E(X) = np
- Variance: Var(X) = np(1-p)
- R functions: dbinom(), pbinom()
- Medical applications: vaccine efficacy, treatment success rates

### Normal Distribution
- Properties of normal distribution
- Standardization and Z-scores
- Empirical rule (68-95-99.7)
- Finding probabilities and percentiles
- R functions: pnorm(), qnorm(), dnorm()
- Medical applications: cholesterol levels, blood pressure, height

### t-Distribution
- When to use t vs. z
- Degrees of freedom
- Comparison with normal distribution
- R function: qt()

### Sampling Distributions
- Distribution of sample means
- Standard error: SE = σ/√n
- Difference between SD and SE
- Effect of sample size

### Central Limit Theorem
- Statement and implications
- Works for any population distribution
- Applications with non-normal populations
- Simulation demonstrations

### Confidence Intervals
- Interpretation of confidence intervals
- Manual calculation steps
- Using t.test() in R
- Effect of confidence level and sample size
- Common misinterpretations

---

## R Functions Covered

**Binomial:**
- `dbinom(x, size, prob)` - probability mass function
- `pbinom(q, size, prob, lower.tail)` - cumulative probability

**Normal:**
- `dnorm(x, mean, sd)` - density function
- `pnorm(q, mean, sd, lower.tail)` - cumulative probability
- `qnorm(p, mean, sd)` - quantiles/percentiles
- `rnorm(n, mean, sd)` - random generation

**t-distribution:**
- `qt(p, df)` - critical values
- `t.test(x, conf.level)` - confidence intervals

**Other:**
- `scale()` - standardization
- `replicate()` - simulations
- `hist()`, `plot()`, `barplot()` - visualizations

---

## AI Integration

All materials include sections on:
- Using AI tools to check work
- Asking AI for concept explanations
- Debugging R code with AI assistance
- Verifying AI-generated solutions
- Academic integrity guidelines

Bonus assignment question (5 points) asks students to:
1. Use AI to solve a problem
2. Verify the AI's answer step-by-step
3. Evaluate AI explanation of CLT with medical example

---

## Medical Examples Used

1. **Medication effectiveness** - 80% success rate (binomial)
2. **Vaccine efficacy** - 85-92% protection (binomial)
3. **Antibiotic treatment** - 75% success (binomial)
4. **Adult height** - normal distribution (170 cm, 10 cm SD)
5. **Cholesterol levels** - normal distribution (200 mg/dL, 40 mg/dL SD)
6. **Blood pressure** - normal distribution (125 mmHg, 18 mmHg SD)
7. **Blood glucose** - sampling distribution (100 mg/dL, 20-25 mg/dL SD)
8. **Birth weights** - CLT application (3400g, 500g SD)
9. **Pain reduction scores** - confidence intervals
10. **Tumor growth** - t-distribution CI
11. **Clinical trials** - comprehensive integration

---

## File Sizes and Statistics

| File Type | Count | Total Size |
|-----------|-------|------------|
| PDF files | 6 | ~1.1 MB |
| R code files | 2 | 44 KB |
| LaTeX source | 6 | ~120 KB |
| Canvas files | 3 | ~34 KB |

**Total materials:** 17 files across 4 directories

---

## Alignment with Syllabus

**Week 3 Learning Objectives (from syllabus):**
✓ Understand theoretical probability distributions
✓ Work with binomial and normal distributions
✓ Apply the Central Limit Theorem
✓ Understand sampling distribution of the mean
✓ Calculate and interpret confidence intervals
✓ Use R for distribution calculations
✓ Integrate AI tools for learning and verification

**Reading:** Pagano & Gauvreau
- ✓ Chapter 7: 7.1 (Binomial), 7.2 (Normal), 7.4 (Other distributions)
- ✓ Chapter 8: Sampling distributions and confidence intervals

---

## Next Steps for Instructor

1. **Review materials** for any desired adjustments
2. **Upload to Canvas:**
   - Import assignments/week3_assignment_canvas.zip
   - Upload slides, worksheet, lab PDFs
   - Post R code files
3. **Print materials** as needed:
   - Worksheet for in-class activity
   - Answer keys for grading
4. **Test R code** in classroom environment
5. **Prepare lecture notes** using slides as guide

---

## Notes

- All LaTeX files compile successfully with pdflatex
- All R code has been syntax-checked and runs without errors
- Proper math notation used throughout (e.g., $\mid$ for conditional probability)
- Consistent color scheme: OSU orange for headers, AI blue for AI sections
- Answer keys include detailed solutions and grading guidance
- Canvas QTI file ready for direct import
- Materials follow same structure and quality as Weeks 1 and 2

---

## Contact for Issues

If you encounter any compilation errors or need modifications:
1. Check LaTeX installation (requires pdflatex)
2. Verify R version compatibility (code tested with R 4.x)
3. Ensure all package dependencies are installed
4. Recompile PDFs if .tex files are modified

---

**Status:** ✓ All Week 3 materials complete and ready for use

**Last updated:** October 12, 2025
