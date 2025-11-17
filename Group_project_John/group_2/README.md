# Group 2: Pima Diabetes Study

## Dataset Overview

**File:** `pima_diabetes.csv`

**Sample Size:** n = 768 Pima Indian women

**Research Context:** Cross-sectional study examining risk factors for diabetes in Pima Indian women. Multiple health measures collected to identify which factors are associated with diabetes diagnosis.

## Variables

- `glu`: Plasma glucose concentration (mg/dL)
- `bmi`: Body mass index (kg/m²)
- `age`: Age (years)
- `type`: Diabetes diagnosis (No or Yes)
- Additional variables may include: blood pressure, pregnancies, skin fold thickness, insulin levels

## Loading the Data in R

```r
# Load the dataset
pima <- read.csv("pima_diabetes.csv")

# View structure
str(pima)
head(pima)

# Summary by diabetes status
table(pima$type)
tapply(pima$glu, pima$type, summary)
tapply(pima$bmi, pima$type, summary)
```

## Suggested Research Question

**"Which health factors are associated with diabetes? Do glucose levels, BMI, and age differ between women with and without diabetes?"**

## Methods to Use (From Course Material)

This dataset is designed for **Week 6 and Week 8 methods**:

1. **Exploratory Analysis** (Week 1)
   - Summary statistics by diabetes status
   - Boxplots: `boxplot(glu ~ type, data=pima)`
   - Histograms by group

2. **Two-Sample t-tests** (Week 6) - For continuous predictors
   - Glucose: `t.test(glu ~ type, data=pima)`
   - BMI: `t.test(bmi ~ type, data=pima)`
   - Age: `t.test(age ~ type, data=pima)`
   - Tests: Do these variables differ between diabetes groups?

3. **Chi-Square Tests** (Week 8) - If you categorize variables
   - Create categories (e.g., high/normal glucose)
   - Test association with diabetes
   - `chisq.test(table(pima$glucose_cat, pima$type))`

4. **Check Assumptions** (Weeks 6-7)
   - Normality: Histograms, Q-Q plots, Shapiro-Wilk test
   - Equal variances: Visual check with boxplots
   - If assumptions violated: Use Wilcoxon rank-sum test (Week 7)

## What AI Will Likely Suggest (Divergence!)

When you ask AI tools about this dataset, they will likely suggest:

- **Logistic regression** (analyzing all predictors together)
  - NOT taught in this course
  - Predicts binary outcome (diabetes yes/no) from multiple predictors
  - More sophisticated but beyond intro scope
  - AI will say "logistic regression is the right method for binary outcomes"

- **Multiple regression** (if treating diabetes as continuous somehow)
  - NOT taught in this course (Week 9 is simple regression only)

- **ROC curves and classification metrics**
  - NOT taught in this course
  - Diagnostic test evaluation methods

**Your Task:** Use simple two-sample t-tests and/or chi-square tests (Weeks 6 & 8) to examine ONE predictor at a time. In your AI comparison section, note that AI suggested logistic regression to analyze all predictors together, and explain why testing variables individually is appropriate for this course.

## Expected AI Divergence

- **Claude** might suggest logistic regression with multiple predictors (not taught)
- **ChatGPT** will almost certainly suggest logistic regression (standard for binary outcomes)
- **Copilot** might suggest either approach depending on your code context

**Focus your report on:**
- Why did ALL tools suggest logistic regression?
- Is logistic regression "better"? (Yes, for multiple predictors, but we haven't learned it!)
- Did individual t-tests answer the research question? (Yes! We found which factors differ!)
- What's the limitation of one-at-a-time testing? (Doesn't account for relationships between predictors)

## Tips

- Test 2-3 main predictors (glucose, BMI, age) - don't try to test everything!
- T-tests are straightforward: Does variable X differ between diabetes groups?
- Each test answers: "Is this factor associated with diabetes?"
- AI wants to combine all predictors - that's advanced!
- Your approach is simpler but still scientifically valid

## Interpretation Guide

If you find significant differences:
- **Glucose higher in diabetes group** → Glucose associated with diabetes
- **BMI higher in diabetes group** → Obesity risk factor
- **Age higher in diabetes group** → Age-related risk

This identifies risk factors one at a time (univariate analysis), which is appropriate for intro biostatistics!

## Optional: Compare What AI Suggests

You don't need to run logistic regression, but you could explore:

```r
# Your approach (taught)
t.test(glu ~ type, data=pima)
t.test(bmi ~ type, data=pima)
t.test(age ~ type, data=pima)

# What AI might suggest (not taught, just to see)
# model <- glm(type ~ glu + bmi + age, data=pima, family="binomial")
# summary(model)
```

For your report: Note that AI suggested the second approach. Explain why the first approach (your approach) is appropriate for this course and answers the question!

## Getting Help

- Office hours (see syllabus)
- Week 9 drop-in session (Wed 12-1:20pm)
- Textbook: Chapter 11 (Two-Sample Tests), Chapter 15 (Chi-Square)
- Your team!
