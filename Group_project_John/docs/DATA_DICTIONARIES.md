# Data Dictionaries for Group Project Datasets

## Dataset 1: Anorexia Treatment Study (Group 1)

**File:** `anorexia.csv`
**Source:** MedDataSets R package
**Original Study:** Hand et al. (1994), Treatment of anorexia nervosa
**Sample Size:** N = 72 patients
**Study Design:** Pre-post intervention study with 3 treatment groups

### Research Context
This dataset comes from a study examining the effectiveness of different therapeutic approaches for treating anorexia nervosa, a serious eating disorder characterized by abnormally low body weight and intense fear of gaining weight.

### Variables

| Variable | Type | Description | Values/Range | Missing |
|----------|------|-------------|--------------|---------|
| **Treat** | Categorical (3 levels) | Treatment group assignment | "Cont" = Control (no treatment)<br>"CBT" = Cognitive Behavioral Therapy<br>"FT" = Family Therapy | 0 |
| **Prewt** | Continuous | Patient weight before treatment (pounds) | Range: 70.0 - 94.9 lbs | 0 |
| **Postwt** | Continuous | Patient weight after treatment (pounds) | Range: 71.3 - 103.6 lbs | 0 |

### Sample Sizes by Group
- Control: n = 26
- CBT: n = 29
- Family Therapy: n = 17

### Suggested Research Questions
1. Which treatment is most effective for weight gain in anorexia patients?
2. Do all three treatments lead to significant weight change?
3. Is there a difference in effectiveness between CBT and Family Therapy?

### Suggested Statistical Methods
- Paired t-tests (within-group pre-post comparison)
- One-way ANOVA on change scores (between-group comparison)
- ANCOVA (adjusting for baseline weight)
- Pairwise comparisons with Tukey HSD adjustment

### Notes
- Unequal sample sizes across groups
- Family Therapy group is smallest (n=17)
- Some patients lost weight during treatment (negative change scores possible)
- No missing data

---

## Dataset 2: Tooth Growth Study (Group 2)

**File:** `toothgrowth.csv`
**Source:** MedDataSets R package
**Original Study:** Crampton, E.W. (1947), Effect of Vitamin C on tooth growth in guinea pigs
**Sample Size:** N = 60 guinea pigs
**Study Design:** 2×3 factorial experiment (2 supplements × 3 doses)

### Research Context
This classic study investigated the effect of vitamin C on tooth growth in guinea pigs, comparing two delivery methods (orange juice vs ascorbic acid) at three different dose levels.

### Variables

| Variable | Type | Description | Values/Range | Missing |
|----------|------|-------------|--------------|---------|
| **len** | Continuous | Tooth length (odontoblasts) in millimeters | Range: 4.2 - 33.9 mm | 0 |
| **supp** | Categorical (2 levels) | Supplement type | "OJ" = Orange Juice<br>"VC" = Ascorbic Acid (Vitamin C) | 0 |
| **dose** | Continuous (3 levels) | Dose of vitamin C per day | 0.5 = 0.5 mg/day<br>1.0 = 1.0 mg/day<br>2.0 = 2.0 mg/day | 0 |

### Sample Sizes
- Each combination: n = 10 guinea pigs
- Total: 2 supplements × 3 doses × 10 = 60

### Design Matrix

| | 0.5 mg | 1.0 mg | 2.0 mg |
|---|--------|--------|--------|
| **Orange Juice** | n=10 | n=10 | n=10 |
| **Vitamin C** | n=10 | n=10 | n=10 |

### Suggested Research Questions
1. Does vitamin C dose affect tooth growth?
2. Is there a difference between orange juice and ascorbic acid delivery?
3. Is there an interaction between supplement type and dose?

### Suggested Statistical Methods
- One-way ANOVA (treating 6 groups independently)
- Two-way ANOVA (supplement × dose, including interaction)
- Linear regression (dose as continuous predictor)
- Pairwise comparisons with multiple testing adjustment

### Notes
- Balanced design (equal n per cell)
- Dose can be treated as continuous (for trend analysis) or categorical (for group comparisons)
- Interaction effect likely present (different dose-response by supplement type)
- No missing data

---

## Dataset 3: Low Birth Weight Study (Group 3)

**File:** `birthwt.csv`
**Source:** MedDataSets R package
**Original Study:** Hosmer and Lemeshow (1989), Baystate Medical Center data
**Sample Size:** N = 189 births
**Study Design:** Retrospective case-control study

### Research Context
This dataset examines risk factors associated with giving birth to a low birth weight baby (< 2500 grams), an important indicator of infant health and development.

### Variables

| Variable | Type | Description | Values/Range | Missing |
|----------|------|-------------|--------------|---------|
| **low** | Binary | Low birth weight indicator | 0 = Normal weight (≥2500g)<br>1 = Low birth weight (<2500g) | 0 |
| **age** | Continuous | Mother's age in years | Range: 14 - 45 years | 0 |
| **lwt** | Continuous | Mother's weight at last menstrual period (pounds) | Range: 80 - 250 lbs | 0 |
| **race** | Categorical (3 levels) | Mother's race | 1 = White<br>2 = Black<br>3 = Other | 0 |
| **smoke** | Binary | Smoking status during pregnancy | 0 = Non-smoker<br>1 = Smoker | 0 |
| **ptl** | Count | Number of previous premature labors | Range: 0 - 3 | 0 |
| **ht** | Binary | History of hypertension | 0 = No<br>1 = Yes | 0 |
| **ui** | Binary | Presence of uterine irritability | 0 = No<br>1 = Yes | 0 |
| **ftv** | Count | Number of physician visits in first trimester | Range: 0 - 6 | 0 |
| **bwt** | Continuous | Birth weight in grams | Range: 709 - 4990 g | 0 |

### Sample Characteristics
- Low birth weight cases: n = 59 (31%)
- Normal birth weight: n = 130 (69%)

### Suggested Research Questions
1. What maternal factors are associated with low birth weight?
2. Does smoking during pregnancy increase risk of low birth weight?
3. How do multiple risk factors combine to affect birth weight?

### Suggested Statistical Methods
- Two-sample t-tests (comparing continuous variables by low birth weight status)
- Chi-square tests (comparing categorical variables by low birth weight status)
- Correlation between maternal age/weight and birth weight
- Risk ratios or odds ratios for binary predictors
- Multiple group comparisons (stratified analyses)

### Notes
- **Two outcome options**: Can analyze `low` (binary) OR `bwt` (continuous)
- Binary analysis uses chi-square and risk ratios
- Continuous analysis uses t-tests and correlation
- Multiple potential confounders (age, smoking, hypertension)
- No missing data

---

## Dataset 4: Pima Indian Diabetes Study (Group 4)

**File:** `pima_diabetes.csv`
**Source:** MedDataSets R package
**Original Study:** National Institute of Diabetes and Digestive and Kidney Diseases
**Sample Size:** N = 200 Pima Indian women
**Study Design:** Cross-sectional observational study

### Research Context
The Pima Indians of Arizona have one of the highest rates of type 2 diabetes in the world. This dataset examines predictors of diabetes in Pima Indian women aged 21+ years.

### Variables

| Variable | Type | Description | Values/Range | Missing/Issues |
|----------|------|-------------|--------------|----------------|
| **npreg** | Count | Number of pregnancies | Range: 0 - 14 | 0 |
| **glu** | Continuous | Plasma glucose concentration (mg/dL) 2 hours after oral glucose tolerance test | Range: 56 - 199 | **Some 0 values (implausible!)** |
| **bp** | Continuous | Diastolic blood pressure (mm Hg) | Range: 38 - 110 | **Some 0 values (missing data coded as 0)** |
| **skin** | Continuous | Triceps skin fold thickness (mm) | Range: 7 - 99 | **Some 0 values (missing data coded as 0)** |
| **bmi** | Continuous | Body mass index (weight in kg / height in m²) | Range: 18.2 - 47.9 | **Some 0 values (missing data coded as 0)** |
| **ped** | Continuous | Diabetes pedigree function (genetic influence) | Range: 0.085 - 2.288 | 0 |
| **age** | Continuous | Age in years | Range: 21 - 63 | 0 |
| **type** | Categorical (2 levels) | Diabetes diagnosis | "No" = No diabetes<br>"Yes" = Diabetes | 0 |

### Sample Characteristics
- Diabetes cases: n = 68 (34%)
- No diabetes: n = 132 (66%)

### ⚠️ CRITICAL DATA QUALITY ISSUE ⚠️

**Missing data coded as 0:** Several physiological variables have 0 values which are **biologically impossible**:
- Blood pressure = 0 (person would be dead!)
- BMI = 0 (impossible)
- Glucose = 0 (impossible for living person)

**These are actually MISSING values** incorrectly coded as 0.

**What to do:**
1. Identify which variables have 0 values
2. Check if 0 is plausible for that variable
3. If not, treat 0 as missing (NA in R)
4. Document your data cleaning decisions

**This is a TEST of AI data cleaning abilities!** Will AI tools catch this?

### Suggested Research Questions
1. What factors predict diabetes in Pima Indian women?
2. Is glucose level the strongest predictor of diabetes?
3. How does age relate to diabetes prevalence?

### Suggested Statistical Methods
- Two-sample t-tests (comparing continuous predictors by diabetes status)
- Chi-square tests (if you categorize continuous variables)
- Correlation analysis between predictors
- Data cleaning and missing data handling

### Notes
- **Data quality issues make this dataset educational!**
- Tests AI tools' ability to detect implausible values
- Missing data handling required before analysis
- Multiple potential predictors
- Strong correlation between some variables (multicollinearity)

---

## Dataset 5: Type 2 Diabetes Treatment Trial (Group 5)

**File:** `diabetes2.csv`
**Source:** MedDataSets R package
**Study Context:** Clinical trial for adolescents (ages 10-17) with type 2 diabetes
**Sample Size:** N = 699 adolescents
**Study Design:** Randomized controlled trial with 3 treatment arms

### Research Context
This dataset comes from a clinical trial testing different treatments for type 2 diabetes in adolescents aged 10-17 years, comparing lifestyle intervention, metformin alone, and combination therapy.

### Variables

| Variable | Type | Description | Values/Range | Missing |
|----------|------|-------------|--------------|---------|
| **treatment** | Categorical (3 levels) | Treatment group assignment | "lifestyle" = Lifestyle intervention only<br>"met" = Metformin medication<br>"met+" = Metformin + lifestyle | 0 |
| **outcome** | Binary | Treatment success | "success" = Glycemic control achieved<br>"failure" = Treatment failed | 0 |

### Sample Sizes by Treatment Group
- Lifestyle: n = 233
- Metformin: n = 233
- Metformin + lifestyle: n = 233

**Note:** Perfectly balanced design (equal n per group)

### Success Rates (Approximate)
- Lifestyle: ~40% success
- Metformin: ~45% success
- Metformin+: ~55% success

### Suggested Research Questions
1. Which treatment is most effective for glycemic control in adolescents?
2. Is combination therapy (metformin + lifestyle) superior to either alone?
3. Is metformin alone better than lifestyle intervention alone?

### Suggested Statistical Methods
- Chi-square test (3×2 contingency table)
- Pairwise comparisons between treatments
- Risk ratios or risk differences
- Proportion tests with multiple comparison adjustment
- Number needed to treat (NNT) calculations

### Notes
- **Cleanest dataset of the 5** - No missing data, balanced design
- Binary outcome makes analysis straightforward
- Three groups allow multiple pairwise comparisons
- Good for learning multiple comparison adjustments
- Large sample size provides good statistical power

---

## Comparing the 5 Datasets

| Dataset | N | Design | Outcome Type | Complexity | Messiness |
|---------|---|--------|--------------|------------|-----------|
| **Anorexia** | 72 | Pre-post, 3 groups | Continuous | High | Medium |
| **ToothGrowth** | 60 | 2×3 factorial | Continuous | High | Low |
| **Birth Weight** | 189 | Case-control | Binary (or continuous) | Medium | Medium |
| **Pima Diabetes** | 200 | Observational | Binary | Medium | **High** (data quality issues!) |
| **Diabetes Trial** | 699 | RCT, 3 groups | Binary | Low | Low (very clean) |

### Which Dataset is "Hardest"?

**Statistically:** ToothGrowth (factorial design with interaction)
**Data cleaning:** Pima Diabetes (missing data coded as 0)
**Interpretation:** Anorexia (pre-post with unequal groups)
**Easiest:** Diabetes Trial (clean 3-group comparison)

---

## General Notes for All Datasets

### Data Loading
All datasets available in two formats:
1. CSV files (in your group folder)
2. MedDataSets R package

### Citation
If you use these datasets in presentations or reports, cite:
> Data from the MedDataSets R package (Caceres Rossi, 2024). Original studies cited in individual dataset descriptions.

### Getting Help
- Data dictionary questions: Post on Canvas discussion board
- Variable clarification: Ask during office hours
- Statistical method selection: Part of your AI comparison assignment!

---

**Created:** November 2, 2025
**For:** H524 Introduction to Biostatistics Group Project
**Instructor:** Dr. John Molitor
