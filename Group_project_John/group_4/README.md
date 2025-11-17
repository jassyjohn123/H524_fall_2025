# Group 4: Vitamin D Supplementation Study

## Dataset Overview

**File:** `vitamin_d.csv`

**Sample Size:** n = 45 adults (15 per dose group)

**Research Context:** Randomized controlled trial comparing three vitamin D supplement doses (Low, Medium, High) on vitamin D blood levels after 8 weeks.

## Variables

- `id`: Participant identifier (1-45)
- `group`: Supplement dose group (Low, Medium, High)
- `baseline`: Baseline vitamin D level before supplementation (ng/mL)
- `vitamin_d`: Vitamin D level after 8 weeks of supplementation (ng/mL)
- `age`: Age in years

## Loading the Data in R

```r
# Load the dataset
data <- read.csv("vitamin_d.csv")

# View structure
str(data)
head(data)

# Summary by group
tapply(data$vitamin_d, data$group, summary)
```

## Suggested Research Question

**"Do different vitamin D supplement doses lead to different vitamin D blood levels?"**

## Methods to Use (From Course Material)

This dataset is designed for **Week 6 methods**:

1. **Exploratory Analysis** (Week 1)
   - Boxplots by group: `boxplot(vitamin_d ~ group, data=data)`
   - Summary statistics by group: `tapply(vitamin_d, group, mean)`

2. **One-Way ANOVA** (Week 6)
   - `model <- aov(vitamin_d ~ group, data=data)`
   - `summary(model)`
   - Tests: Are the three group means different?

3. **Post-Hoc Testing** (Week 6)
   - `TukeyHSD(model)`
   - Which specific pairs differ? (Low vs Medium? Medium vs High?)

4. **Check Assumptions** (Week 6)
   - Normality: `shapiro.test()` for each group or Q-Q plot
   - Equal variances: `bartlett.test()` or visual check with boxplots
   - Independence: Each participant measured once (built into design)

## What AI Will Likely Suggest (Divergence!)

When you ask AI tools about this dataset, they may suggest different approaches:

- **Advanced methods** (like ANCOVA or repeated measures ANOVA)
  - NOT taught in this course - redirect AI if it suggests these
  - AI may say these are "statistically optimal" for designs with baseline measurements
  - Tell AI you need methods from introductory biostatistics

- **Change scores analysis** (vitamin_d - baseline)
  - Similar to ANOVA but on the change
  - This IS a valid alternative using taught methods!

- **Linear regression with dose as continuous** (treating Low=1, Medium=2, High=3)
  - NOT taught for categorical predictors in this course
  - Tests for linear trend instead of group differences

**Your Task:** Use one-way ANOVA on the `vitamin_d` outcome (Week 6 method). In your AI comparison section, note if AI suggested advanced methods, and explain how you redirected it to use appropriate introductory methods.

## Expected AI Divergence

- **Claude** might suggest advanced methods (statistically optimal but not taught)
- **ChatGPT** might suggest different approaches depending on how you phrase the question
- **Copilot** might generate code for multiple approaches

**Focus your report on:**
- Why did tools differ in their recommendations?
- Did any tools suggest methods beyond this course? How did you redirect them?
- Did simple ANOVA answer the research question? (Yes!)
- What does this teach about AI suggesting methods beyond your training?

## Tips

- Start with boxplots (visualize group differences)
- ANOVA tests overall difference (p-value tells you if ANY groups differ)
- Tukey post-hoc tells you WHICH specific pairs differ
- The `baseline` variable is interesting - some AI will want to use it!
- Don't be intimidated if AI suggests advanced methods - explain why ANOVA is fine

## Optional: Try Both Approaches

If you're curious, you COULD also analyze change scores:

```r
data$change <- data$vitamin_d - data$baseline
model2 <- aov(change ~ group, data=data)
summary(model2)
```

This uses taught methods (ANOVA on change = paired thinking from Week 6). Compare results to ANOVA on vitamin_d - do you get similar conclusions?

## Getting Help

- Office hours (see syllabus)
- Week 9 drop-in session (Wed 12-1:20pm)
- Textbook: Chapter 12 (Analysis of Variance)
- Your team!
