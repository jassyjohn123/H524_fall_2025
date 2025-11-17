# Group 3: Exercise & Cholesterol Study

## Dataset Overview

**File:** `exercise_cholesterol.csv`

**Sample Size:** n = 50 adults

**Research Context:** Study examining the relationship between weekly exercise hours and total cholesterol levels in adults.

## Variables

- `id`: Participant identifier (1-50)
- `exercise`: Weekly exercise hours (continuous, 0-10 hours)
- `cholesterol`: Total cholesterol level (mg/dL)
- `age`: Age in years
- `sex`: Sex (M/F)

## Loading the Data in R

```r
# Load the dataset
data <- read.csv("exercise_cholesterol.csv")

# View structure
str(data)
head(data)

# Summary statistics
summary(data)
```

## Suggested Research Question

**"Is there a relationship between weekly exercise hours and cholesterol levels?"**

## Methods to Use (From Course Material)

This dataset is designed for **Week 9 methods**:

1. **Exploratory Analysis** (Week 1)
   - Scatterplot: `plot(exercise, cholesterol)`
   - Summary statistics for both variables

2. **Correlation Test** (Week 9)
   - `cor.test(data$exercise, data$cholesterol)`
   - Tests whether correlation is significantly different from 0

3. **Simple Linear Regression** (Week 9)
   - `lm(cholesterol ~ exercise, data=data)`
   - `summary(model)`
   - Check: Does exercise predict cholesterol?
   - Interpret: For each additional hour of exercise per week, cholesterol changes by ___ mg/dL

4. **Check Assumptions** (Week 9)
   - Residual plots: `plot(model)`
   - Normality of residuals
   - Constant variance

## What AI Will Likely Suggest (Divergence!)

When you ask AI tools about this dataset, they may suggest:

- **Multiple linear regression** (adding age, sex as predictors)
  - NOT taught in this course (Week 9 is simple regression only)
  - More complex but not necessary for basic research question

- **Polynomial regression** (exercise^2 term)
  - NOT taught in this course
  - Tests for curved relationship

- **Interaction terms** (exercise × sex)
  - NOT taught in this course

**Your Task:** Use the simple methods from Week 9 (correlation, simple regression). In your AI comparison section, note that AI suggested more complex methods but explain why simple regression is appropriate for your research question.

## Expected AI Divergence

- **Claude** might suggest checking assumptions thoroughly, recommend diagnostics
- **ChatGPT** might jump to multiple regression with all variables
- **Copilot** might suggest similar code but with different variable selection

**Focus your report on:** Why did tools differ? Which suggestion was most appropriate given what you learned in Weeks 1-9? Did any tool make errors?

## Tips

- Start with a scatterplot (visualize the relationship first)
- Correlation gives you strength and direction
- Regression gives you prediction equation and tests significance
- Don't let AI overcomplicate things - simple methods often answer the question!
- Document what each AI tool suggested and WHY you chose your approach

## Getting Help

- Office hours (see syllabus)
- Week 9 drop-in session (Wed 12-1:20pm)
- Textbook: Chapters 17-18 (Correlation and Simple Linear Regression)
- Your team!
