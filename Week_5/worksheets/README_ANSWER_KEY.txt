Week 5 Hypothesis Testing Worksheet - Answer Key Documentation
================================================================

FILES CREATED:
1. week5_hypothesis_testing_worksheet_KEY.tex  - LaTeX source for answer key
2. week5_hypothesis_testing_worksheet_KEY.pdf  - Compiled PDF answer key
3. verify_answers.R                             - R script with all verified calculations

COMPUTATIONAL VERIFICATION:
All numerical answers have been verified using R computational methods.
NO mental arithmetic was used - all calculations were performed by R.

KEY VERIFIED VALUES:
--------------------

Problem 1 (Two-sided t-test):
  - SE = 0.16
  - t-statistic = -1.25
  - p-value = 0.2234 (two-sided)
  - Decision: Fail to reject H0

Problem 2 (One-sided t-test, upper tail):
  - SE = 7.5895
  - t-statistic = 3.294
  - p-value = 0.0011 (one-sided)
  - Decision: Reject H0

Problem 3 (Critical value approach):
  - t_critical = 1.6849 (one-sided, alpha=0.05, df=39)
  - Decision: Reject H0 (confirms Problem 2)

Problem 4:
  - Conceptual questions on Type I and Type II errors
  - No numerical calculations

Problem 5:
  - Conceptual questions on power and sample size
  - Example: SE for n=20: 2.2361, SE for n=80: 1.1180

Problem 6 (Comprehensive integration):
  - SE = 0.1697
  - t-statistic = -1.1785
  - p-value = 0.1221 (one-sided lower tail)
  - t_critical = -2.4049 (alpha=0.01)
  - Decision: Fail to reject H0

VERIFICATION WORKFLOW:
----------------------
1. Created verify_answers.R FIRST (before writing answer key)
2. Ran R script to compute ALL numerical values
3. Used verified results to populate answer key LaTeX
4. Compiled LaTeX to PDF
5. All numbers in answer key match R output exactly

PRODUCTION READY:
-----------------
✓ All calculations verified computationally
✓ LaTeX compiles without errors
✓ PDF generated successfully (11 pages, 157K)
✓ Follows Week 4 worksheet style
✓ OSU orange header with green answer text
✓ Includes note referencing verification script
✓ Problems cover all Week 5 hypothesis testing topics

TOPICS COVERED:
---------------
1. Setting up hypotheses (H0 vs HA)
2. Two-sided vs one-sided tests
3. Calculating t-statistics
4. Finding p-values
5. Critical value approach
6. Making decisions (reject vs fail to reject)
7. Interpreting results in context
8. Type I and Type II errors
9. Statistical power and sample size
10. Relationship between CIs and hypothesis tests

This answer key is ready for classroom use.
