# Group 4: Pima Indian Diabetes Study

## Your Dataset
**File:** `pima_diabetes.csv`

## Quick Overview
- **N = 200 Pima Indian women**
- **Cross-sectional study:** 68 with diabetes, 132 without
- **Multiple predictors:** Glucose, BP, BMI, age, pregnancies
- **Research Question:** What factors predict diabetes?

## Variables
- `npreg`: Number of pregnancies
- `glu`: Plasma glucose (mg/dL)
- `bp`: Diastolic blood pressure (mm Hg)
- `skin`: Triceps skin fold thickness (mm)
- `bmi`: Body mass index
- `ped`: Diabetes pedigree function (genetic)
- `age`: Age in years
- `type`: Diabetes status ("No" or "Yes")

## ⚠️ CRITICAL DATA QUALITY ISSUE!

**Missing data coded as 0!** Some variables have 0 values that are biologically impossible:
- Blood pressure = 0 (impossible!)
- BMI = 0 (impossible!)
- Glucose = 0 (impossible!)

**These are MISSING values incorrectly coded as 0.**

**This tests whether AI tools catch data quality issues!**

## Loading Your Data in R

```r
pima <- read.csv("pima_diabetes.csv")

# Or from package
library(MedDataSets)
data("Pima_tr_df")
```

## What Makes This Dataset Interesting for AI Comparison?

**High divergence - tests data cleaning!** Different AI tools might:
- **ChatGPT:** MIGHT detect impossible 0 values (glucose=0?)
- **Claude:** Might miss data quality issues entirely
- **Copilot:** Depends on what code you've written before

**This is the ULTIMATE TEST of AI data awareness!**

## Suggested Statistical Methods
1. **FIRST:** Data cleaning!
   ```r
   # Check for 0 values
   summary(pima)
   
   # Replace impossible 0s with NA
   pima$bp[pima$bp == 0] <- NA
   pima$bmi[pima$bmi == 0] <- NA
   # etc.
   ```

2. **THEN:** Statistical analysis
   - T-tests comparing predictors by diabetes status
   - Chi-square if you categorize continuous variables
   - Correlation between predictors

## Tips for Success
1. **Data cleaning is PART OF THE ASSIGNMENT!**
2. Check every variable for plausible values
3. Document which AI tool caught the data quality issues
4. Decide how to handle missing data (exclude? impute?)
5. This dataset specifically tests AI's data cleaning abilities

## For More Details
See `docs/DATA_DICTIONARIES.md` - pay special attention to data quality notes!

---
**Data cleaning is statistics!** Don't skip this step.
