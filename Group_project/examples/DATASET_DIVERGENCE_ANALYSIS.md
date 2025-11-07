# MedDataSets: AI Divergence Potential Analysis

**Purpose:** Identify datasets from MedDataSets package that will elicit **different responses** from different AI tools (ChatGPT, Claude, Copilot), maximizing learning about AI comparison and critical evaluation.

**Date:** November 2, 2025

---

## Divergence Scoring Criteria

Datasets scored on 0-10 scale based on:

1. **Design Complexity** (0-3 pts): Multiple groups, pre-post, repeated measures
2. **Assumption Violations** (0-2 pts): Non-normality, unequal variances, outliers
3. **Method Ambiguity** (0-3 pts): Multiple valid analytical approaches
4. **Sample Size** (0-2 pts): 50-200 optimal (too large = no divergence, too small = all AI flag it)

**Target:** Scores ≥7 are high-divergence datasets ideal for AI comparison pedagogy

---

## TIER 1: Highest Divergence Potential (Scores 8-10)

### 1. **anorexia_df** — Score: 9/10 ✓ (CURRENT EXAMPLE)

**Structure:**
- N = 72 (26 Control, 29 CBT, 17 FT)
- Variables: Treat (3 levels), Prewt, Postwt
- Design: Pre-post with 3 treatment groups

**Why High Divergence:**
- ✓ Pre-post design → Multiple analytical paths (change scores, ANCOVA, paired t-tests)
- ✓ Three groups → ANOVA vs multiple t-tests decisions
- ✓ Unequal sample sizes → Power/validity concerns
- ✓ Assumption violations present (normality in CBT group, p=0.0079)
- ✓ Multiple comparison problem (needs Tukey HSD or adjustment)

**Expected AI Differences:**
- Claude: ANOVA on change scores, no assumption checks
- ChatGPT: ANCOVA + assumption checks + effect sizes
- Copilot: Might suggest paired t-tests or simple comparisons

**Intro-Appropriate:** YES - uses ANOVA, t-tests (Week 5-6 material)

---

### 2. **ToothGrowth_df** — Score: 8/10 ✓ RECOMMENDED

**Structure:**
- N = 60 (10 per cell in 2×3 design)
- Variables: len (tooth length), supp (OJ vs VC), dose (0.5, 1.0, 2.0 mg)
- Design: 2-way factorial (2 supplements × 3 doses)

**Why High Divergence:**
- ✓ Can analyze as 2-way ANOVA (advanced) OR separate 1-way ANOVAs
- ✓ Three dose levels → Trend analysis possible
- ✓ Interaction effect possible (some AI will test, others won't)
- ✓ Multiple comparison issue (6 groups total)
- ✓ Continuous predictor (dose) could be treated as categorical or continuous

**Expected AI Differences:**
- ChatGPT: Likely suggests 2-way ANOVA with interaction (too advanced)
- Claude: Might do separate analyses for each supplement
- Copilot: Could suggest comparing all 6 groups or just main effects

**Intro-Appropriate:** PARTIAL - 1-way ANOVA yes, 2-way ANOVA typically Week 8+
**Recommendation:** Great for advanced students or later in semester

---

### 3. **bacteria_df** — Score: 8/10 ✓ RECOMMENDED (with caveats)

**Structure:**
- N = 220 measurements from 50 patients
- Variables: y (bacteria present), trt (placebo/drug/drug+), week (0,2,4,6,11), ID
- Design: **Repeated measures** over time with 3 treatment groups

**Why High Divergence:**
- ✓ Repeated measures design → Most intro students haven't learned this!
- ✓ Binary outcome → Chi-square? Logistic? Proportion tests?
- ✓ Time component → Which timepoints to compare?
- ✓ 2-5 measurements per person (varies) → Missing data decisions
- ✓ Three treatment groups → Multiple comparisons

**Expected AI Differences:**
- ChatGPT: Might suggest repeated measures ANOVA or mixed models (WAY too advanced!)
- Claude: Might analyze each timepoint separately (simpler but ignores clustering)
- Copilot: Unclear - depends on context provided

**Intro-Appropriate:** NO - Repeated measures beyond intro scope
**Recommendation:** Only use if you WANT to teach students to recognize complexity they can't handle yet (valuable lesson: "This requires methods beyond this course")

---

### 4. **birthwt_df** — Score: 8/10 ✓ RECOMMENDED

**Structure:**
- N = 189 births
- Variables: low (binary: low birth weight), age, lwt (mother's weight), race, smoke, ptl, ht, ui, ftv, bwt (birth weight continuous)
- Design: Observational with binary outcome + multiple predictors

**Why High Divergence:**
- ✓ Binary outcome → Multiple analytical approaches (chi-square, risk ratios, logistic regression)
- ✓ Many predictors (9 variables) → Which to use?
- ✓ Can analyze 'low' (binary) OR 'bwt' (continuous) - different outcomes!
- ✓ Confounding variables present → Adjustment decisions
- ✓ Continuous predictors → Categorize or keep continuous?

**Expected AI Differences:**
- ChatGPT: Might jump to multivariable logistic regression (too advanced)
- Claude: Likely suggests chi-square tests and stratified analysis
- Copilot: Might do simple t-tests on continuous outcome (bwt)

**Intro-Appropriate:** PARTIAL - Chi-square and t-tests yes, logistic regression no
**Recommendation:** Excellent if you emphasize simple bivariate analyses, avoiding multivariable models

---

### 5. **Pima_tr_df** (Pima Diabetes) — Score: 7/10

**Structure:**
- N = 200
- Variables: type (diabetes yes/no), npreg, glu, bp, skin, bmi, ped, age
- Design: Binary outcome with multiple continuous predictors

**Why High Divergence:**
- ✓ Binary outcome with multiple predictors → Method selection varies
- ✓ Glucose highly predictive → Some AI might focus only on this
- ✓ Missing data coded as 0 for some variables (e.g., bp=0, bmi=0) → AI might catch or miss this!
- ✓ Multicollinearity possible (bmi, skin, weight related)
- ✓ Age as continuous vs categorical

**Expected AI Differences:**
- ChatGPT: Might detect missing data issues (glucose=0 doesn't make sense!)
- Claude: Might miss missing data coding
- Copilot: Depends on data exploration done first

**Intro-Appropriate:** YES for bivariate comparisons (t-tests, chi-square)
**Recommendation:** Good test of AI's data cleaning abilities!

---

## TIER 2: Moderate Divergence Potential (Scores 5-7)

### 6. **esoph_df** — Score: 6/10

**Structure:**
- N = 88 observations
- Variables: agegp (6 levels), alcgp (4 levels), tobgp (4 levels), ncases, ncontrols
- Design: Case-control study with aggregated counts

**Why Moderate Divergence:**
- ✓ Aggregated data (counts) → Not standard data frame structure
- ✓ Ordinal predictors → Trend tests possible
- ✓ Multiple risk factors → Which primary?
- ✗ Small cell counts in some combinations

**Expected AI Differences:**
- Handling of aggregated count data
- Chi-square vs Mantel-Haenszel tests
- Trend analysis for ordinal variables

**Intro-Appropriate:** PARTIAL - Aggregated data might confuse intro students

---

### 7. **diabetes2_tbl_df** — Score: 6/10

**Structure:**
- N = 699
- Variables: treatment (lifestyle/met/met+), outcome (failure/success)
- Design: 3 treatments × 2 outcomes (simple but large)

**Why Moderate Divergence:**
- ✓ Three treatment groups → Multiple comparisons
- ✓ Binary outcome → Proportions, chi-square, risk ratios
- ✗ Large sample size → Less concern about assumptions
- ✗ Clean data → Less messiness to test AI

**Intro-Appropriate:** YES - Standard chi-square

**Recommendation:** Good but perhaps too straightforward for divergence

---

### 8. **sleep_deprivation_tbl_df** — Score: 5/10

**Structure:**
- N = 1,087
- Variables: sleep (3 categories: <6, 6-8, >8), profession (5 categories)
- Design: 3×5 contingency table

**Why Moderate Divergence:**
- ✓ 3×5 table → Multiple ways to collapse/compare
- ✗ Very large sample → All tests will have power
- ✗ Ordered sleep categories → Most AI will suggest chi-square

**Intro-Appropriate:** YES

---

## TIER 3: Low Divergence Potential (Scores 1-4)

### Simple 2×2 Designs (AVOID for AI comparison)

**sinusitis_tbl_df** — Score: 2/10
- N=166, 2 groups, binary outcome
- TOO SIMPLE: All AI will say "chi-square test"
- No divergence learning

**yawn_tbl_df** — Score: 2/10
- N=50, 2 groups, binary outcome
- TOO SIMPLE: All AI will say "chi-square or Fisher's exact"
- No divergence learning

**malaria_tbl_df** — Score: 2/10
- N=20, 2×2 table
- TOO SIMPLE + TOO SMALL: All AI will say "Fisher's exact test"
- No divergence learning

**stent30_tbl_df** — Score: 3/10
- N=451, 2 groups, binary outcome
- CLEAN AND SIMPLE: All AI agree on chi-square
- Minimal divergence

---

## RECOMMENDED DATASET PORTFOLIO FOR GROUP PROJECT

Based on divergence potential + intro-appropriateness:

### **Core Recommended Set (5 datasets):**

1. **anorexia_df** (Current) — Pre-post, 3 groups, ANOVA focus
2. **ToothGrowth_df** — Factorial design, dose-response
3. **birthwt_df** — Binary outcome, multiple predictors, missing data issues
4. **Pima_tr_df** — Similar to birthwt but with data cleaning challenges
5. **diabetes2_tbl_df** — Clean 3-group comparison with binary outcome

**Rationale:**
- Variety of designs (pre-post, factorial, observational)
- Mix of continuous and binary outcomes
- Range of sample sizes (60-699)
- Different levels of messiness
- All intro-appropriate with standard methods
- All will elicit different AI responses

---

## TESTING PROTOCOL

Before assigning a dataset, test divergence:

### Quick Test:
1. Upload to ChatGPT: "Analyze this dataset comparing [outcome] across [groups]"
2. Upload to Claude: Same prompt
3. Try Copilot in R with minimal context

### Success Criteria:
- ✓ Different statistical methods suggested
- ✓ Different assumption checking rigor
- ✓ Different interpretation emphasis
- ✓ At least 2 of 3 AI tools differ substantially

### If All Three Agree:
→ Dataset too simple, don't use for AI comparison project

---

## SPECIAL CONSIDERATIONS

### For Advanced Students:
- **bacteria_df**: Introduces repeated measures complexity
- **ToothGrowth_df**: 2-way ANOVA learning opportunity

### For Data Cleaning Focus:
- **Pima_tr_df**: Missing data coded as 0 (tricky!)
- **birthwt_df**: Multiple coding decisions

### For Communication Focus:
- **anorexia_df**: Clinical implications clear
- **diabetes2_tbl_df**: Public health relevance obvious

---

## WHAT TO AVOID

**Datasets that will NOT create divergence:**

❌ **Simple 2-group comparisons** (sinusitis, yawn, malaria, stent30)
- All AI tools will agree: chi-square or t-test
- No learning about AI differences

❌ **Very large samples** (>1000) with clean data
- Statistical significance everywhere
- No assumption concerns
- Boring for AI comparison

❌ **Time series datasets** (fdeaths_ts, ldeaths_ts, mdeaths_ts)
- Requires time series methods (beyond intro)
- Not appropriate for comparison

❌ **Survival data** (Aids2, gehan, leuk, Melanoma, VA)
- Requires survival analysis (beyond intro)
- AI will all suggest inappropriate methods OR advanced methods

---

## FINAL RECOMMENDATION

**Assign 4-5 datasets from Core Recommended Set**

**Allow teams to choose** from the 4-5, ensuring:
- Multiple teams per dataset (for comparison across teams)
- Variety across the class

**Alternative:** All teams use SAME dataset (e.g., anorexia) but compare AI tools → easier to discuss as class

---

## DOCUMENTATION TO CREATE

For each dataset you assign, create:

1. **Data Dictionary** (variables, coding, sample size)
2. **Expected Divergence Notes** (what AI differences to expect)
3. **Learning Objectives** (what students should discover)
4. **Verification Guide** (how to check AI outputs)
5. **Discussion Questions** (for comparing AI approaches)

---

**Created by:** Claude Code Analysis
**Date:** November 2, 2025
**Source:** MedDataSets R package (CRAN)
