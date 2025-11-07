# Group 3: Low Birth Weight Study

## Your Dataset
**File:** `birthwt.csv`

## Quick Overview
- **N = 189 births**
- **Case-control design:** 59 low birth weight, 130 normal
- **Multiple predictors:** Maternal age, weight, smoking, race, hypertension, etc.
- **Research Question:** What factors are associated with low birth weight?

## Variables
- `low`: Low birth weight indicator (0=no, 1=yes)
- `age`: Mother's age (years)
- `lwt`: Mother's weight at last menstrual period (lbs)
- `race`: Mother's race (1=White, 2=Black, 3=Other)
- `smoke`: Smoking status (0=no, 1=yes)
- `ptl`: Previous premature labors (count)
- `ht`: History of hypertension (0=no, 1=yes)
- `ui`: Uterine irritability (0=no, 1=yes)
- `ftv`: First trimester doctor visits (count)
- `bwt`: Birth weight in grams (continuous alternative outcome)

## Loading Your Data in R

```r
birthwt <- read.csv("birthwt.csv")

# Or from package
library(MedDataSets)
data("birthwt_df")
```

## What Makes This Dataset Interesting for AI Comparison?

**High divergence potential!** Different AI tools will likely:
- **Claude:** Focus on major risk factors (smoking), chi-square tests
- **ChatGPT:** Might jump to logistic regression (too advanced!)
- **Copilot:** Might analyze continuous outcome (bwt) instead

**Why they differ:**
- TWO possible outcomes: `low` (binary) vs `bwt` (continuous)
- Many predictors - which to focus on?
- Some AI might suggest multivariable models (beyond intro scope)

## Suggested Statistical Methods
- **For binary outcome (low):** Chi-square tests, risk ratios
- **For continuous outcome (bwt):** T-tests, correlation
- Compare means of predictors by low birth weight status
- Stratified analysis (e.g., by smoking status)

## Tips for Success
1. Decide which outcome to use: binary `low` or continuous `bwt`
2. Don't try to analyze all 9 predictors - focus on 2-3 main ones
3. Watch if AI suggests logistic regression (too advanced for intro!)
4. Consider confounding: smoking AND hypertension together?
5. Risk ratios easier to interpret than odds ratios for intro class

## For More Details
See `docs/DATA_DICTIONARIES.md` for complete variable descriptions.

---
**Multiple predictors = lots to explore!**
