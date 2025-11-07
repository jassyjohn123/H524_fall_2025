# Group 5: Type 2 Diabetes Treatment Trial

## Your Dataset
**File:** `diabetes2.csv`

## Quick Overview
- **N = 699 adolescents** (ages 10-17)
- **Randomized controlled trial:** 3 treatment groups
- **Balanced design:** n=233 per group
- **Research Question:** Which treatment is most effective?

## Variables
- `treatment`: Treatment group (lifestyle, met, met+)
  - `lifestyle` = Lifestyle intervention only
  - `met` = Metformin medication
  - `met+` = Metformin + lifestyle combined
- `outcome`: Treatment success (success, failure)

## Loading Your Data in R

```r
diabetes <- read.csv("diabetes2.csv")

# Or from package
library(MedDataSets)
data("diabetes2_tbl_df")
```

## What Makes This Dataset Interesting for AI Comparison?

**Moderate divergence - cleanest dataset!** Different AI tools will:
- **All agree:** Chi-square test appropriate
- **Differ on:** Which pairwise comparisons to make
- **Differ on:** Risk ratio vs odds ratio terminology
- **Differ on:** Multiple comparison adjustments

**This is the "control" dataset** - when data is clean, AI tools mostly agree!

## Suggested Statistical Methods
- Chi-square test (3×2 contingency table)
- Pairwise comparisons:
  - Lifestyle vs Metformin
  - Lifestyle vs Combination
  - Metformin vs Combination
- Risk ratios or risk differences
- Number needed to treat (NNT)
- Multiple comparison adjustment (Bonferroni?)

## Sample Data Structure

| | Success | Failure | Total |
|---|---------|---------|-------|
| Lifestyle | ~93 | ~140 | 233 |
| Metformin | ~105 | ~128 | 233 |
| Met+ | ~128 | ~105 | 233 |

## Tips for Success
1. This is the cleanest, most straightforward dataset
2. Perfect for learning chi-square and multiple comparisons
3. All three AI tools should suggest similar methods
4. Focus on: which pairwise comparisons to make?
5. How to adjust for multiple testing?
6. Risk ratios are more intuitive than odds ratios

## For More Details
See `docs/DATA_DICTIONARIES.md` for complete variable descriptions.

---
**Clean data, clear question - good for mastering basics!**
