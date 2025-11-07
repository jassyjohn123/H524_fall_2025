# Group 1: Anorexia Treatment Study

## Your Dataset
**File:** `anorexia.csv`

## Quick Overview
- **N = 72 patients** with anorexia nervosa
- **3 treatment groups:** Control, CBT, Family Therapy
- **Pre-post design:** Weight measured before and after treatment
- **Research Question:** Which treatment is most effective?

## Variables
- `Treat`: Treatment group (Cont, CBT, FT)
- `Prewt`: Pre-treatment weight (pounds)
- `Postwt`: Post-treatment weight (pounds)

## Loading Your Data in R

```r
# Method 1: From CSV
anorexia <- read.csv("anorexia.csv")

# Method 2: From MedDataSets package
library(MedDataSets)
data("anorexia_df")
```

## What Makes This Dataset Interesting for AI Comparison?

**High divergence potential!** Different AI tools will likely suggest:
- **Claude:** ANOVA on change scores, accessible narrative
- **ChatGPT:** ANCOVA adjusting for baseline, more rigorous
- **Copilot:** Paired t-tests or simple comparisons

**Why they differ:**
- Pre-post design has multiple valid analytical approaches
- 3 groups create multiple comparison decisions
- Unequal sample sizes raise power considerations
- Assumption violations present (test if AI catches them!)

## Suggested Statistical Methods
- Calculate change scores: `change <- Postwt - Prewt`
- One-way ANOVA comparing change across 3 groups
- Paired t-tests within each group
- ANCOVA (advanced): adjust post-weight for pre-weight
- Tukey HSD for pairwise comparisons

## Tips for Success
1. Check ANOVA assumptions (normality, equal variances)
2. Watch for unequal sample sizes (FT only n=17)
3. Consider both statistical AND clinical significance
4. Pay attention to whether AI tools check assumptions!

## For More Details
See `docs/DATA_DICTIONARIES.md` for complete variable descriptions and research context.

---
**Good luck!** Remember to document what each AI tool suggests and compare their approaches critically.
