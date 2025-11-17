# Group 1: Anorexia Treatment Study

## Dataset Overview

**File:** `anorexia.csv`

**Sample Size:** n = 72 patients with anorexia nervosa (Cont=26, CBT=29, FT=17)

**Research Context:** Clinical trial comparing three treatments for anorexia: Control, Cognitive Behavioral Therapy (CBT), and Family Therapy (FT). Weight measured before and after treatment.

## Variables

- `Treat`: Treatment group (Cont=Control, CBT=Cognitive Behavioral Therapy, FT=Family Therapy)
- `Prewt`: Pre-treatment weight (pounds)
- `Postwt`: Post-treatment weight (pounds)

## Loading the Data in R

```r
# Load the dataset
anorexia <- read.csv("anorexia.csv")

# View structure
str(anorexia)
head(anorexia)

# Summary by treatment group
tapply(anorexia$Prewt, anorexia$Treat, summary)
tapply(anorexia$Postwt, anorexia$Treat, summary)
```

## Suggested Research Question

**"Which treatment is most effective for increasing weight in anorexia patients?"**

## Methods to Use (From Course Material)

This dataset is designed for **Week 6 methods**:

1. **Calculate Change Scores** (paired thinking from Week 6)
   - `anorexia$change <- anorexia$Postwt - anorexia$Prewt`
   - This converts pre/post into a single outcome per person

2. **Exploratory Analysis** (Week 1)
   - Boxplots by group: `boxplot(change ~ Treat, data=anorexia)`
   - Summary statistics: `tapply(change, Treat, mean)`

3. **One-Way ANOVA** (Week 6)
   - `model <- aov(change ~ Treat, data=anorexia)`
   - `summary(model)`
   - Tests: Are the three treatment groups different in weight change?

4. **Post-Hoc Testing** (Week 6)
   - `TukeyHSD(model)`
   - Which specific treatments differ? (Cont vs CBT? CBT vs FT? Cont vs FT?)

5. **Check Assumptions** (Week 6)
   - Normality: Q-Q plot or Shapiro-Wilk test for each group
   - Equal variances: Boxplot check or Bartlett test
   - Note: Unequal sample sizes (FT only n=17) but ANOVA handles this

## What AI Will Likely Suggest (Divergence!)

When you ask AI tools about this dataset, they may suggest different approaches:

- **Advanced methods** (like ANCOVA or repeated measures ANOVA)
  - NOT taught in this course - redirect AI if it suggests these
  - AI may say these are "statistically optimal" for pre-post designs
  - Tell AI you need methods from introductory biostatistics

- **Multiple paired t-tests** (within each group separately)
  - This IS taught (Week 6) but doesn't compare ACROSS groups
  - Answers different question: "Did each treatment work?" not "Which is best?"

- **ANOVA on change scores** (comparing weight gain across groups)
  - This IS taught (Week 6) - THE CORRECT APPROACH
  - Compares all three treatments simultaneously
  - Simple, appropriate, and answers the research question

**Your Task:** Use ANOVA on change scores (Week 6 method). In your AI comparison section, note if AI suggested advanced methods, and explain how you redirected it to use appropriate introductory methods.

## Expected AI Divergence

- **Claude** might suggest advanced methods (statistically optimal but not taught)
- **ChatGPT** might suggest different approaches depending on how you phrase the question
- **Copilot** might suggest paired t-tests within each group (different question)

**Focus your report on:**
- Why did tools differ in their recommendations?
- Did any tools suggest methods beyond this course? How did you redirect them?
- Did ANOVA on change scores answer the research question? (Yes!)
- What does this teach about AI suggesting methods beyond your training?

## Tips

- Start with boxplots of change scores by group (visualize differences)
- Change scores handle the pre/post design with taught methods
- ANOVA tests overall difference (p-value tells if ANY groups differ)
- Tukey post-hoc tells you WHICH specific pairs differ
- Don't be intimidated if AI suggests ANCOVA - explain why change scores work

## Optional: Compare Approaches

If you're curious, you could compare using final weight vs. change scores:

```r
# Approach 1: ANOVA on change scores (recommended)
anorexia$change <- anorexia$Postwt - anorexia$Prewt
model1 <- aov(change ~ Treat, data=anorexia)
summary(model1)

# Approach 2: ANOVA on final weight only
model2 <- aov(Postwt ~ Treat, data=anorexia)
summary(model2)
```

Do you get similar conclusions? This could be interesting for your AI comparison section!

## Getting Help

- Office hours (see syllabus)
- Week 9 drop-in session (Wed 12-1:20pm)
- Textbook: Chapter 12 (Analysis of Variance)
- Your team!
