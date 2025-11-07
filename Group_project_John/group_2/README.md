# Group 2: Tooth Growth Study

## Your Dataset
**File:** `toothgrowth.csv`

## Quick Overview
- **N = 60 guinea pigs**
- **2×3 factorial design:** 2 supplements × 3 doses
- **Balanced:** n=10 per cell
- **Research Question:** Does vitamin C affect tooth growth? Does delivery method matter?

## Variables
- `len`: Tooth length (mm)
- `supp`: Supplement type (OJ = Orange Juice, VC = Vitamin C)
- `dose`: Vitamin C dose (0.5, 1.0, 2.0 mg/day)

## Loading Your Data in R

```r
# Method 1: From CSV
toothgrowth <- read.csv("toothgrowth.csv")

# Method 2: From MedDataSets package
library(MedDataSets)
data("ToothGrowth_df")
```

## What Makes This Dataset Interesting for AI Comparison?

**High divergence potential!** Different AI tools will likely suggest:
- **Claude:** Separate analyses by supplement type
- **ChatGPT:** Two-way ANOVA with interaction (advanced!)
- **Copilot:** Might treat as 6 independent groups

**Why they differ:**
- Factorial design can be analyzed multiple ways
- Dose is continuous but used as categorical (3 levels)
- Interaction effect likely present
- Some approaches appropriate for intro, others advanced

## Suggested Statistical Methods
- **Simple:** One-way ANOVA treating 6 groups independently
- **Advanced:** Two-way ANOVA (supplement × dose + interaction)
- **Alternative:** Separate one-way ANOVAs for each supplement
- **Trend:** Linear regression using dose as continuous

## Tips for Success
1. Visualize the data first - look for interaction pattern
2. Decide: treat dose as categorical or continuous?
3. Two-way ANOVA is advanced - okay for intro class?
4. Check whether AI suggests methods beyond course scope
5. Interaction = "does the effect of dose depend on supplement type?"

## For More Details
See `docs/DATA_DICTIONARIES.md` for complete variable descriptions.

---
**Good luck with the factorial design!**
