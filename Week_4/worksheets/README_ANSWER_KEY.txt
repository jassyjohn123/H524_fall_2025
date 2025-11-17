Week 4 Confidence Intervals Worksheet - Answer Key
===================================================
Created: October 19, 2025

FILES CREATED:
--------------
1. week4_confidence_intervals_worksheet_KEY.tex (LaTeX source, 9 pages)
2. week4_confidence_intervals_worksheet_KEY.pdf (Compiled PDF, 170 KB)
3. verify_answers.R (R verification script)

VERIFICATION:
-------------
All numerical answers have been verified computationally using R.
No mental arithmetic was used - all calculations confirmed by running verify_answers.R

ANSWER KEY CONTENTS:
--------------------
Complete solutions for all 6 problems plus reflection questions:

Problem 1: CI for Population Mean
- Part A: SE = 1.923
- Part B: t-critical = 2.093 (df=19)
- Part C: ME = 4.02
- Part D: 95% CI = (38.48, 46.52)
- Part E: Full interpretation provided

Problem 2: Effect of Confidence Level
- Part A: 90% CI = (39.17, 45.83)
- Part B: 99% CI = (37.00, 48.00)
- Part C: Pattern analysis - intervals get wider with higher confidence
- Part D: Discussion of confidence vs. precision trade-off

Problem 3: CI for a Proportion
- Part A: p-hat = 0.872
- Part B: Conditions checked (218, 32 both >= 10)
- Part C: SE = 0.0211
- Part D: 95% CI = (83.06%, 91.34%)
- Part E: Vaccine efficacy interpretation

Problem 4: Sample Size Planning
- Part A: z-critical = 1.96
- Part B: n = 171 (for ME = 6)
- Part C: n = 385 (for ME = 4)
- Part D: Explanation of inverse square relationship

Problem 5: Comparing Two CIs
- Part A: SE_A = 1.601, SE_B = 0.877
- Part B: t-critical values (2.145, 2.010)
- Part C: CI_A = (24.97, 31.83), CI_B = (26.64, 30.16)
- Part D: Width comparison and SE explanation
- Part E: Sample size vs. precision relationship

Problem 6: Integration Problem - Blood Pressure Study
- Part A: 95% CI = (10.97, 14.63)
- Part B: Can claim > 10 mmHg reduction (entire CI above 10)
- Part C: n = 50 needed for ME = 1.5
- Part D: Proportion CI = (39.32%, 71.79%)

Reflection Questions:
- Detailed sample answers for all 5 reflection questions
- Explanations of CI interpretation, t vs. Z, factors affecting width,
  sample size planning, and comparing CIs for means vs. proportions

FORMATTING:
-----------
- OSU orange header with "ANSWER KEY" designation
- Green color for all answers (\textcolor{answergreen})
- Yellow box at top noting all answers verified with R
- Clear step-by-step solutions with formulas shown
- Contextual interpretations provided
- All calculations shown with intermediate steps

COMPUTATIONAL VERIFICATION:
---------------------------
Run verify_answers.R to see all calculations:

$ Rscript verify_answers.R

This script:
- Computes all numerical answers using R
- Displays results with clear labeling
- Confirms no mental arithmetic was used
- Provides audit trail for all calculations

USAGE:
------
Use this answer key for:
- Grading student worksheets
- Providing detailed feedback
- Preparing for in-class discussion
- Verifying student R code results
- Understanding complete solution process
