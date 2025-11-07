# TOP 5 DATASETS FOR AI COMPARISON PEDAGOGY
## Quick Reference Guide

---

## 1. **anorexia_df** ⭐ (CURRENT - KEEP IT!)

```
N = 72 | 3 groups (CBT=29, Control=26, FT=17) | Pre-post design
```

**What Makes It Perfect:**
- Pre-post design → Multiple valid approaches (ANOVA on change, ANCOVA, paired t-tests)
- 3 unequal groups → Multiple comparison issues
- Has assumption violations (CBT fails normality)
- Real messiness that tests AI rigor

**AI Will Disagree On:**
- Method: ANOVA vs ANCOVA vs paired tests
- Assumption checking: Some will, some won't
- Multiple comparisons: Tukey HSD or not?
- Effect sizes: Some report, some don't

**Intro-Level:** ✅ YES - Uses ANOVA, t-tests, basic methods

---

## 2. **ToothGrowth_df** ⭐⭐ HIGHLY RECOMMENDED

```
N = 60 | 2 supplements × 3 doses = 6 groups | Balanced design (n=10 each)
```

**What Makes It Perfect:**
- 2×3 factorial design → Can analyze multiple ways
- Dose is continuous (0.5, 1, 2) → Categorize or use as continuous?
- Interaction possible (supplement × dose)
- 6 groups total → Complex comparisons

**AI Will Disagree On:**
- 2-way ANOVA (advanced) vs separate 1-way ANOVAs (intro)
- Dose as categorical vs continuous
- Interaction testing (some will, some won't)
- Post-hoc comparison strategies

**Intro-Level:** ⚠️  PARTIAL - 1-way ANOVA yes, 2-way ANOVA usually Week 8+
**Best For:** Later in semester or advanced students

---

## 3. **birthwt_df** ⭐⭐ HIGHLY RECOMMENDED

```
N = 189 births | Binary outcome (low birth weight) | 9 predictors
```

**What Makes It Perfect:**
- Two outcomes available: 'low' (binary) OR 'bwt' (continuous)
- Multiple predictors → Variable selection decisions
- Continuous predictors → Categorize age? Keep continuous?
- Real confounders (smoking, race, hypertension)

**AI Will Disagree On:**
- Binary vs continuous outcome analysis
- Which predictors to focus on
- Logistic regression (too advanced!) vs simple comparisons
- Adjustment for confounders

**Intro-Level:** ✅ YES if focus on bivariate analyses (t-tests, chi-square)
**Warning:** Some AI will suggest logistic regression (too advanced)

---

## 4. **Pima_tr_df** ⭐ RECOMMENDED

```
N = 200 | Diabetes (yes/no) | 7 predictors | Has data quality issues!
```

**What Makes It Perfect:**
- **HIDDEN TRAP:** Missing data coded as 0 (bp=0, bmi=0 are impossible!)
- Binary outcome with multiple predictors
- Glucose highly predictive (might dominate analysis)
- Tests AI data cleaning abilities

**AI Will Disagree On:**
- Whether they catch the missing data issue! (ChatGPT might, Claude might not)
- Which predictor is "primary"
- Univariate vs multivariable approach
- Categorization of continuous variables

**Intro-Level:** ✅ YES for simple comparisons
**Special Value:** Tests AI data quality awareness!

---

## 5. **diabetes2_tbl_df** ⭐ RECOMMENDED (Clean baseline)

```
N = 699 | 3 treatments | Binary outcome (success/failure) | Very clean
```

**What Makes It Perfect:**
- Three treatment groups (lifestyle, metformin, metformin+)
- Binary outcome → Chi-square, risk ratios, multiple comparisons
- Large sample → Power not an issue
- Clean data → Good for students new to analysis

**AI Will Disagree On:**
- Pairwise vs overall chi-square
- Risk ratio vs odds ratio terminology
- Which treatment is "reference"
- Multiple comparison adjustment

**Intro-Level:** ✅ YES - Standard chi-square analysis
**Note:** Less "messy" than others, but still creates divergence

---

## COMPARISON MATRIX

| Dataset | N | Design | Outcome | Complexity | Messiness | Intro-OK? |
|---------|---|--------|---------|------------|-----------|-----------|
| anorexia | 72 | Pre-post, 3 grp | Continuous | High | Medium | ✅ YES |
| ToothGrowth | 60 | 2×3 factorial | Continuous | High | Low | ⚠️  Partial |
| birthwt | 189 | Observational | Binary | Medium | Medium | ✅ YES |
| Pima | 200 | Observational | Binary | Medium | High | ✅ YES |
| diabetes2 | 699 | 3 groups | Binary | Low | Low | ✅ YES |

---

## RECOMMENDED ASSIGNMENT STRATEGY

### **Option A: Same Dataset, Different AI Tools**
- All teams analyze **anorexia_df**
- Team 1: Primarily ChatGPT
- Team 2: Primarily Claude
- Team 3: Primarily Copilot
- Team 4: Mix of all three
- Final presentations compare approaches

**Pro:** Easy to compare across teams
**Con:** Less variety in statistical methods practiced

---

### **Option B: Different Datasets, All Use All AI Tools**
- 4-5 teams, each gets different dataset from Top 5
- Each team consults all three AI tools
- Teams document AI differences within their dataset
- Presentations show dataset-specific AI behaviors

**Pro:** More statistical variety
**Con:** Harder to compare across teams

---

### **Option C: Round-Robin (Advanced)**
- Week 4: All teams analyze anorexia (practice)
- Week 5-6: Teams get assigned different dataset from Top 5
- Week 7: Teams present, class discusses patterns

**Pro:** Practice + variety
**Con:** More time-intensive

---

## WHAT TO EXPECT FROM EACH DATASET

### **anorexia_df:**
- **ChatGPT:** ANCOVA, assumption checks, effect sizes, advanced
- **Claude:** ANOVA on change scores, accessible language, no assumption checks
- **Copilot:** Paired t-tests or simple comparisons, code-focused

### **ToothGrowth_df:**
- **ChatGPT:** 2-way ANOVA with interaction (too advanced!)
- **Claude:** Separate analyses by supplement, clearer narrative
- **Copilot:** Might suggest comparing all 6 groups directly

### **birthwt_df:**
- **ChatGPT:** Logistic regression (too advanced!), catches importance of multiple predictors
- **Claude:** Focuses on main risk factors, chi-square tables
- **Copilot:** Might analyze continuous outcome (bwt) instead of binary

### **Pima_tr_df:**
- **ChatGPT:** MIGHT catch missing data coded as 0 ⭐
- **Claude:** Might miss data quality issues
- **Copilot:** Depends on exploratory code written first

### **diabetes2_tbl_df:**
- **All three agree more on this one** (it's cleaner)
- But differ on: reference category, multiple comparisons, effect size reporting
- Good "control" dataset to show when AI DOES agree

---

## FILES TO CREATE FOR EACH DATASET

```
examples/
├── anorexia.csv                    ✓ (you have this)
├── toothgrowth.csv                 ← extract from MedDataSets
├── birthwt.csv                     ← extract from MedDataSets
├── pima_diabetes.csv               ← extract from MedDataSets
├── diabetes2.csv                   ← extract from MedDataSets
│
├── data_dictionaries/
│   ├── anorexia_codebook.pdf
│   ├── toothgrowth_codebook.pdf
│   ├── birthwt_codebook.pdf
│   ├── pima_codebook.pdf
│   └── diabetes2_codebook.pdf
│
└── ai_comparison_guides/
    ├── anorexia_expected_differences.md
    ├── toothgrowth_expected_differences.md
    ├── birthwt_expected_differences.md
    ├── pima_expected_differences.md
    └── diabetes2_expected_differences.md
```

---

## IMMEDIATE NEXT STEPS

1. ✅ Keep anorexia_df (it's perfect!)

2. Extract 4 more datasets from MedDataSets:
   ```r
   library(MedDataSets)

   data("ToothGrowth_df")
   write.csv(ToothGrowth_df, "toothgrowth.csv", row.names=FALSE)

   data("birthwt_df")
   write.csv(birthwt_df, "birthwt.csv", row.names=FALSE)

   data("Pima_tr_df")
   write.csv(Pima_tr_df, "pima_diabetes.csv", row.names=FALSE)

   data("diabetes2_tbl_df")
   write.csv(diabetes2_tbl_df, "diabetes2.csv", row.names=FALSE)
   ```

3. Create data dictionaries for each

4. Test each dataset with ChatGPT and Claude to document actual divergence

5. Create student handouts explaining expected AI differences

---

**Bottom Line:** You have 5 excellent datasets that will create meaningful AI divergence without being too complex for intro students!
