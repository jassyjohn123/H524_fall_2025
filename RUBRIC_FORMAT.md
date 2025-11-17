# AI Grading Rubric Format

## Overview

Rubrics guide Claude's grading. They can be simple text instructions or detailed per-question criteria.

## Format Options

### Option 1: Simple Text (Recommended for Most Cases)

```
GRADING INSTRUCTIONS:

General Expectations:
- Students should show R code for computational questions
- Award full credit for correct answers with code and interpretation
- Deduct 20% for missing interpretation
- Deduct 30% for missing R code
- Deduct 50% for incorrect analysis

Common Issues to Watch For:
- Using wrong statistical test (e.g., ANOVA instead of t-test)
- Misinterpreting p-values
- Not checking assumptions
- Confusing correlation with causation
```

### Option 2: Per-Question Instructions

```
GLOBAL:
All answers should demonstrate understanding through code + interpretation.

Q1 (10 points):
- Must use mean() function: 4 points
- Must reference correct dataset column: 3 points
- Must provide interpretation in context: 3 points

Q2 (5 points):
- Correct hypothesis statements: 2 points
- Appropriate test selection: 2 points
- Proper conclusion: 1 point

Q3 (15 points):
- Creates proper visualization (histogram/boxplot): 5 points
- Checks normality assumption: 5 points
- Correct interpretation of diagnostics: 5 points
```

### Option 3: Detailed Rubric with Examples

```
GRADING RUBRIC - Week 4 Confidence Intervals

GENERAL CRITERIA:
- Full credit requires R code + interpretation + correct values
- Partial credit for showing work even if answer incorrect
- No credit for just stating an answer with no work shown

QUESTION 1: Calculate 95% CI for mean (10 points)
Breakdown:
- Calculates standard error correctly (2 pts)
- Uses correct t-critical value (2 pts)
- Computes margin of error (2 pts)
- Forms confidence interval (2 pts)
- Interprets in context (2 pts)

Common Errors:
- Using z instead of t (deduct 1 pt)
- Wrong degrees of freedom (deduct 1 pt)
- No interpretation (deduct 2 pts)

QUESTION 2: Sample size calculation (5 points)
Must show formula: n = (z*σ/ME)²
- Correct formula setup (2 pts)
- Correct computation (2 pts)
- Rounds UP to next integer (1 pt)

QUESTION 3: Check normality assumptions (5 points)
- Creates Q-Q plot or histogram (2 pts)
- Runs Shapiro-Wilk test (2 pts)
- Correct interpretation of results (1 pt)
```

## Using the Rubric

When you ask Claude to grade:

```
Grade Week_4/submissions.csv with Week_4/rubric.txt
```

Claude will:
1. Read all student submissions
2. Read the rubric
3. Apply the rubric criteria to each answer
4. Provide specific feedback based on rubric
5. Generate the HTML interface for your review

## Tips for Writing Good Rubrics

### Be Specific
❌ "Check if they understood the concept"
✅ "Award 3 points if they correctly identify Type I error as rejecting true null hypothesis"

### List Common Errors
```
Common mistakes:
- Confusing standard error with standard deviation (-2 pts)
- Using sample size n instead of n-1 for degrees of freedom (-1 pt)
- Stating CI without units (-1 pt)
```

### Provide Examples of Full Credit Answers
```
Full credit answer should include:
- R code: t.test(data$variable, conf.level=0.95)
- Numeric result: CI = (23.5, 32.4) mg/dL
- Interpretation: "We are 95% confident the true mean reduction is between 23.5 and 32.4 mg/dL"
```

### Balance Strictness with Learning
For weekly assignments:
- More lenient on formatting/style
- Focus on correct understanding
- Give partial credit generously

For exams:
- Stricter adherence to methods taught
- Expect precise statistical language
- Partial credit for showed work

## No Rubric?

If you don't provide a rubric, Claude will use reasonable defaults:
- Check for correct statistical methods
- Verify calculations are accurate
- Look for R code and interpretation
- Provide constructive feedback

But a rubric ensures consistent, fair grading aligned with your expectations.
